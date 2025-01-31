//
//  NetworkInterface.swift
//  MultiAdsInterface
//
//  Created by Khusnud Zehra on 30/01/25.
//

import Foundation
import UIKit

public protocol NetworkInterface {
    @available(iOS 13.0.0, *)
     func initNetwork()  -> Bool

    func getAdUnits() -> [Any]

    func isNetworkInit() -> Bool

    // Inter Ads
    func loadInterAd(adModuleCallBacks: AdModuleWithCallBacks?)

    func showInterAd(adModuleCallBacks: AdModuleWithCallBacks?)

    func isInterAdLoaded() -> Bool

    func loadAndShowInterAd(adModuleCallBacks: AdModuleWithCallBacks?)

    // Reward Ads
    func loadRewardAd(adModuleCallBacks: AdModuleWithCallBacks?)

    func showRewardAd(adModuleCallBacks: AdModuleWithCallBacks?)

    func isRewardAdLoaded() -> Bool

    func loadAndShowRewardAd(adModuleCallBacks: AdModuleWithCallBacks?)

    // Reward Inter
    func loadRewardInter(adModuleCallBacks: AdModuleWithCallBacks?)

    func showRewardInter(adModuleCallBacks: AdModuleWithCallBacks?)

    func isRewardInterAdLoaded() -> Bool

    func loadAndShowRewardInter(adModuleCallBacks: AdModuleWithCallBacks?)

    func getNativeAd() -> UIView?

    func getBannerAd() -> UIView?
}

