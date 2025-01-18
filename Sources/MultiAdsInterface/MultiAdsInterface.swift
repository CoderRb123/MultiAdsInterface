import Foundation


public class MultiAdsInterface {
    
    
    
    
    public init() {
        
    }
    
   
    
    
    @MainActor public func setUp() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let identifier:UUID? =  AppTrans().getTrackingIdentifierWithRequest()
            ApiReposiotry().deviceRegister(adId:identifier?.uuidString ?? "00000000-0000-0000-0000-000000000000",rewardType: 1) { deviceID in
            } onError: { ErrorString in
                
            }
        }
       
    }
    

}

