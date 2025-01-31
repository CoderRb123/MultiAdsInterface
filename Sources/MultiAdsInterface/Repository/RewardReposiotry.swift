//
//  RewardReposiotry.swift
//  MultiAdsInterface
//
//  Created by Khusnud Zehra on 31/01/25.
//

import SwiftyJSON

public class RewardReposiotry {
    let apiService: ApiService = ApiService()
    

    public init(){}
    
    
    public func getReward(rewardType:String) -> [JSON?] {
        
        var ar:[JSON?] = []
         apiService.getNormalReward(rewardType: rewardType) { data in
             ar = data?.arrayValue ?? []
        } onError: { ErrorString in
          
            print("⚠️ Error : \(ErrorString)")
        }

        
        return ar
    }
    
    
}
