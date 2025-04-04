//
//  SwiftUIView.swift
//  MultiAdsInterface
//
//  Created by Khusnud Zehra on 01/02/25 For.
//

import SwiftUI

@available(iOS 13.0, *)
public struct AppAdHelper<Content: View>: View {
    let content: () -> Content
    @State var notFirstTime: Bool = false
    let registerAppParameters:RegisterAppParameters
    
    
    public init(@ViewBuilder content: @escaping () -> Content,registerAppParameters: RegisterAppParameters,baseUrl:String) {
        self.content = content
        self.registerAppParameters = registerAppParameters
    }
    public var body: some View {
        content().onAppear {
            if(!notFirstTime){
                
                MultiAdsInterface().setUp(
                    registerAppParameters: RegisterAppParameters(
                        
                        appVersion:registerAppParameters.appVersion,
                        rewardType:registerAppParameters.rewardType,
                        apiKey: registerAppParameters.apiKey,
                        onUpdateLaunch: registerAppParameters.onUpdateLaunch,
                        onError: registerAppParameters.onError,
                        onComplete: { data in
                            notFirstTime = true
                            registerAppParameters.onComplete(data)
                        },
                        requiredAdNetworks:registerAppParameters.requiredAdNetworks
                    )
                )
            }
        }
    }
}


