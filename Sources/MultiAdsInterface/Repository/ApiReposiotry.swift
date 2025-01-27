import IPAPI


/*
   device-register
 */
public class ApiReposiotry {
    let apiService: ApiService = ApiService()
    public init() {}
    @MainActor public func deviceRegister(adId:String,rewardType: Int = 1,onComplete: @escaping (String?) -> Void,onError: @escaping (String) -> Void) {
        Service.default.fetch(fields: [.ip,.isp, .countryName, .city, .regionName, .zipCode]) {
            if let result = try? $0.get() {
                print(result.ip)
                print(result.regionName)
                self.apiService.registerDevice(body: [
                    "device_id": DeviceMethods().getDeviceId()!,
                    "device_name": DeviceMethods().getDeviceName()!,
                    "device_type": "IOS",
                    "device_isp": result.isp ?? "",
                    "device_iifd": adId,
                    "device_os_version": "iOS 17.0",
                    "device_country":  result.countryName ?? "",
                    "device_city":  result.city ?? "",
                    "device_zip":  result.zipCode ?? "",
                    "device_ip": result.ip ?? "",
                    "device_location": result.regionName ?? "",
                    "appName": DeviceMethods().appName,
                    "package": DeviceMethods().package,
                    "version": DeviceMethods().version,
                    "buildNumber": DeviceMethods().buildNumber,
                    "reward_type_id": "1",
                    "device_public_key": DeviceMethods().getDevicePublicKey()
                ],onComplete: onComplete,onError: onError)
            }
        }
        
    }
}
