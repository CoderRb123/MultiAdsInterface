import IPAPI
import Foundation
import SwiftyJSON


/*
   device-register
 */
@available(iOS 13.0, *)
public class ApiReposiotry {
    let apiService: ApiService = ApiService()
    public init() {}
    
    func isVPNConnected() -> Bool {
        let cfDict = CFNetworkCopySystemProxySettings()
        let nsDict = cfDict!.takeRetainedValue() as NSDictionary
        let keys = nsDict["__SCOPED__"] as! NSDictionary

        for key: String in keys.allKeys as! [String] {
            if (key == "tap" || key == "tun" || key == "ppp" || key == "ipsec" || key == "ipsec0" || key == "utun1" || key == "utun2") {
                return true
            }
        }
        return false
    }
    @MainActor public func deviceRegister(adId:String,registerAppParameters:RegisterAppParameters) {
        print("is VPN Connected : \(isVPNConnected())")
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
