//
//  NetworkConst.swift
//  CommonInterface_ios
//
//  Created by Khusnud Zehra on 15/01/25.
//


import SwiftUI


@available(iOS 13.0, *)
public class NetworkConst: ObservableObject {
    
    static let shared = NetworkConst()
    @Published var networkLink = NetworkLinks(baseUrl: nil)
    
    
}


public class NetworkLinks : Identifiable{
    var baseURL = "https://rbtechlab.in/MicroService/public/api/"
    var device_register_url:String
    var get_config_url:String
    var reward_normal_url:String
    var reward_details_url:String
    var reward_claim_url:String
    
    init(baseUrl:String?){
        self.baseURL = baseUrl ?? "https://rbtechlab.in/MicroService/public/api/"
        self.device_register_url   = baseURL + "device-register"
        self.get_config_url        = baseURL + "config/"
        self.reward_normal_url = baseURL + "reward/"
        self.reward_details_url = baseURL + "reward-details/"
        self.reward_claim_url = baseURL + "reward/claim"
    }
    
    
}


//
//let baseURL = "https://rbtechlab.in/MicroService/public/api/"
//let device_register_url = baseURL + "device-register"
//let get_config_url:String = baseURL + "config/"
//let reward_normal_url:String = baseURL + "reward/"
//let reward_details_url:String = baseURL + "reward-details/"
//let reward_claim_url:String = baseURL + "reward/claim"
