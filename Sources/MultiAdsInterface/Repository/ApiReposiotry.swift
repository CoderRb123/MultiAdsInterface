import IPAPI
import SystemConfiguration
import Foundation
import SwiftyJSON


/*
   device-register
 */
@available(iOS 13.0, *)
public class ApiReposiotry {
    let apiService: ApiService = ApiService()
    public init() {}
    
    func isConnectedToVpn() -> Bool {
        let host = "www.example.com"
        guard let reachability = SCNetworkReachabilityCreateWithName(nil, host) else {
            return false
        }
        var flags = SCNetworkReachabilityFlags()
        if SCNetworkReachabilityGetFlags(reachability, &flags) == false {
            return false
        }
        let isOnline = flags.contains(.reachable) && !flags.contains(.connectionRequired)
        if !isOnline {
            return false
        }
        let isMobileNetwork = flags.contains(.isWWAN)
        let isTransientConnection = flags.contains(.transientConnection)
        if isMobileNetwork {
            if let settings = CFNetworkCopySystemProxySettings()?.takeRetainedValue() as? Dictionary<String, Any>,
                let scopes = settings["__SCOPED__"] as? [String:Any] {
                for (key, _) in scopes {
                    if key.contains("tap") || key.contains("tun") || key.contains("ppp") {
                        return true
                    }
                }
            }
            return false
        } else {
            return isTransientConnection
        }
    }
    @MainActor public func deviceRegister(adId:String,registerAppParameters:RegisterAppParameters) {
        print("is VPN Connected : \(isConnectedToVpn())")
        Service.default.fetch(fields: [.ip,.isp, .countryName, .city, .regionName, .zipCode,.proxy]) {
            if let result = try? $0.get() {
                print("Proxy  : \(String(describing: result.proxy))")

                self.apiService.registerDevice(body: [
                    "device_id": DeviceMethods().getDeviceId()!,
                    "device_name": DeviceMethods().getDeviceName()!,
                    "device_type": "IOS",
                    "device_isp": result.isp ?? "",
                    "device_iifd": adId,
                    "device_os_version": DeviceMethods().getDeviceSystemName()!,
                    "device_country":  result.countryName ?? "",
                    "device_city":  result.city ?? "",
                    "device_zip":  result.zipCode ?? "",
                    "device_ip": result.ip ?? "",
                    "device_location": result.regionName ?? "",
                    "appName": DeviceMethods().appName,
                    "package": DeviceMethods().package,
                    "version": DeviceMethods().version,
                    "buildNumber": DeviceMethods().buildNumber,
                    "reward_type_id": registerAppParameters.rewardType.description,
                    "device_public_key": DeviceMethods().getDevicePublicKey()
                ],
                onComplete: { DeviceId in
                    registerAppParameters.onComplete(DeviceId)
                }) { ErrorString in
                    registerAppParameters.onError(ErrorString)
                }
        }
    }
}
    
    @MainActor public func fetchConfig(apiKey: String,appVersion:String,onComplete: @escaping (_ data:JSON?) -> Void,onError: @escaping (String) -> Void) {
        self.apiService.getServerConfigration(apiKey: apiKey, appVersion: appVersion, onComplete: { data in
            print("MultiAds:[_fetchConfig]->Success[✅] : \(String(describing: data))");
            onComplete(data)
        }) { ErrorString in
            print("MultiAds:[_fetchConfig]->Error[❌] : \(ErrorString)");

            onError(ErrorString)
        }
    }
}
