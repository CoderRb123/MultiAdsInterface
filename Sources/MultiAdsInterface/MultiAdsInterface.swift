import Foundation


public class MultiAdsInterface {
    
    
    
    
    public init() {
        
    }
    
   
    
    
    @MainActor public func setUp() {
        
        let identifier:UUID? =  AppTrans().getTrackingIdentifierWithRequest()
        if(identifier != nil){
            ApiReposiotry().deviceRegister(adId:identifier?.uuidString ?? "",rewardType: 1) { deviceID in
            
            } onError: { ErrorString in
                
            }

        }
        
    }
    

}

