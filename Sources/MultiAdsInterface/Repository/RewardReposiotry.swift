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
    
    
    public func getReward(rewardType:String,onComplete: @escaping (_ data:[JSON?]) -> Void,onError: @escaping (String) -> Void){
        
         apiService.getNormalReward(rewardType: rewardType) { data in
             onComplete( data?.arrayValue ?? [])
        } onError: { ErrorString in
          
            onError(ErrorString)
            print("⚠️ Error : \(ErrorString)")
        }

    }
    
    
    public func getDateGroupedReward(rewardType:String,onComplete: @escaping (_ data:[JSON?]) -> Void,onError: @escaping (String) -> Void){
        
         apiService.getDateGroupedReward(rewardType: rewardType) { data in
             onComplete( data?.arrayValue ?? [])
        } onError: { ErrorString in
          
            onError(ErrorString)
            print("⚠️ Error : \(ErrorString)")
        }

    }
    
    public func getStatusGroupedReward(rewardType:String,onComplete: @escaping (_ data:[JSON?]) -> Void,onError: @escaping (String) -> Void){
        
         apiService.getStatusGroupedReward(rewardType: rewardType) { data in
             onComplete( data?.arrayValue ?? [])
        } onError: { ErrorString in
          
            onError(ErrorString)
            print("⚠️ Error : \(ErrorString)")
        }

    }
    
    
}
