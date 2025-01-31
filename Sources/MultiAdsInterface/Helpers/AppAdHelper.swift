//
//  SwiftUIView.swift
//  MultiAdsInterface
//
//  Created by Khusnud Zehra on 01/02/25 For.
//

import SwiftUI

@available(iOS 13.0, *)
struct AppAdHelper<Content: View>: View {
    
    let content: () -> Content
    @State var notFirstTime: Bool = false
    let registerAppParameters:RegisterAppParameters
    init(@ViewBuilder content: @escaping () -> Content,registerAppParameters: RegisterAppParameters) {
        self.content = content
        self.registerAppParameters = registerAppParameters
    }
    var body: some View {
        content().onAppear {
            if(!notFirstTime){
                MultiAdsInterface().setUp(
                    registerAppParameters: registerAppParameters
                )
            }
        }
    }
}


