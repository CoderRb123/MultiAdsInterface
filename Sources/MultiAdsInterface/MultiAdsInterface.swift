import Foundation
import SwiftyJSON
import SwiftUI

@available(iOS 13.0, *)
public class MultiAdsInterface {
    
    
    static  public let shared: MultiAdsInterface = MultiAdsInterface()
    @ObservedObject public var commonState:CommonChangables = CommonChangables.shared
    public init() {
    }

    public func postSetup(data: JSON)  {
        ServerConfig.sharedInstance.configJson = data

        // Parse Screen Data
        let screenDataString = data["versions"][data["activeLevel"].stringValue].stringValue
        if let jsonDict = JsonMethods().convertToDictionary(jsonString: screenDataString) {
            ServerConfig.sharedInstance.screenConfig = JsonMethods().parseScreenData(screenData: jsonDict)
        } else {
            print("⚠️ Error Parsing Screen Data ⚠️")
            print("🐞 Trace From Data [Start]")
            print(screenDataString)
            print("🐞 Trace From Data [End]")
        }

        // Parse AdNetwork Ids
        let adNetworkIds = data["versions"]["adNetworkIds"].stringValue
        if let jsonDict = JsonMethods().convertToDictionary(jsonString: adNetworkIds) {
            ServerConfig.sharedInstance.adNetworkIds = JsonMethods().parseAdNetworkIds(adNetworkIds: jsonDict)
        } else {
            print("⚠️ Error Parsing AdNetworkIds ⚠️")
            print("🐞 Trace From Data [Start]")
            print(adNetworkIds)
            print("🐞 Trace From Data [End]")
        }

        // Parse Global Status
        let globalStatus = data["versions"]["global_ad_status"].intValue
        ServerConfig.sharedInstance.globalAdStatus = globalStatus == 0

        // Parse Init AdNetworks
        let initAdNetworks = data["versions"]["init_ad_network"].stringValue
        if let jsonDict = JsonMethods().convertToArray(jsonString: initAdNetworks) {
            ServerConfig.sharedInstance.initAdNetworks = jsonDict
        } else {
            print("⚠️ Error Parsing InitAdNetwork ⚠️")
            print("🐞 Trace From Data [Start]")
            print(initAdNetworks)
            print("🐞 Trace From Data [End]")
        }

        let onesignalKey = data["onesignal_key"].stringValue
        ServerConfig.sharedInstance.onesignalApiKey = onesignalKey

        // Parse Extra Config
        let extraConfigs = data["versions"]["extra_config"].stringValue
        if let jsonDict = JsonMethods().convertToArrayAny(jsonString: extraConfigs) {
            ServerConfig.sharedInstance.extraConfig = jsonDict[0] as? [String: Any]

        } else {
            print("⚠️ Error Parsing ExtraConfig Array⚠️")
            print("🐞 Trace From Data [Start]")
            print(extraConfigs)
            print("🐞 Trace From Data [End]")
        }
        
        setupAdNetworks()
       
    }
    
   
    @available(iOS 13.0.0, *)
    public func setupAdNetworks()  {
        if(ServerConfig.sharedInstance.loadAdNetwork == nil){
            return
        }
        let loadedNetworks : [NetworkType: NetworkInterface] =  ServerConfig.sharedInstance.loadAdNetwork!
        
        for (type, networkInterface) in loadedNetworks {
        
          let typeName = type.stringName
            if ServerConfig.sharedInstance.initAdNetworks.contains(typeName){
                let res =  networkInterface.initNetwork()
                print("[⚠️] Initialized \(typeName) : \(res)")
            }
         
        }
    }

    @MainActor public func setUp(registerAppParameters: RegisterAppParameters) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            //Setting Loaded AdNetwork
            ServerConfig.sharedInstance.loadAdNetwork = registerAppParameters.requiredAdNetworks
            let identifier: UUID? = AppTrans().getTrackingIdentifierWithRequest()
            
            ApiReposiotry().deviceRegister(adId: identifier?.uuidString ?? "", registerAppParameters: RegisterAppParameters(
                apiKey: registerAppParameters.apiKey,
                onUpdateLaunch: registerAppParameters.onUpdateLaunch,
                onError: { Error in
                   print("Error \(Error)")
                  registerAppParameters.onError(Error.description)
               },
               onComplete: { _ in
                print("On Setup Complete")
                ApiReposiotry().fetchConfig(apiKey: registerAppParameters.apiKey.iosKey ?? "nil", appVersion: registerAppParameters.appVersion) { data in
                    if data != nil {
                        self.postSetup(data: data!)
                        print("On Config Complete")
                        registerAppParameters.onComplete(ServerConfig.sharedInstance.configJson ?? JSON({}))
                    } else {
                        print("INValid Config Else")
                        registerAppParameters.onError("Invalid Config")
                    }
                } onError: { ErrorConfig in
                    print("Error Config \(ErrorConfig)")
                    registerAppParameters.onError(ErrorConfig.description)
                }
            },
            requiredAdNetworks: registerAppParameters.requiredAdNetworks
            )
          )
        }
    }
    
    
    public func showAds(from:String,adCallback:AdModuleWithCallBacks) {
        /*
          This Function Call Screen Based Ads
         
         */
        AdEngine.shared.loadScreenBasedAds(from: from,adCallback: adCallback)
    }
}


@available(iOS 13.0, *)
public extension View {
    func setup(registerAppParameters: RegisterAppParameters){
        MultiAdsInterface().setUp(registerAppParameters: registerAppParameters)
    }
}
