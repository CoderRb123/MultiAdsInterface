//
//  AppTrans.swift
//  MultiAdsInterface
//
//  Created by Khusnud Zehra on 17/01/25.
//

import AppTrackingTransparency
import AdSupport


class AppTrans {
    
    public init () {
        
    }
    
    
    public func getTrackingIdentifierWithRequest() -> UUID? {
        
        if(isTrackingAccessAvailable()){
            requestTrackingAccess {
                print("On Approved")
            } onDecline: {
                print("On Declined")
            }
            return getTrackingIdentifier()
        }
        
        
        return nil;
    }
    
    public func isTrackingAccessAvailable() -> Bool {
        if #available(iOS 14, *) {
            switch ATTrackingManager.trackingAuthorizationStatus {
            case .authorized:
                print("On authorized")
                return true
            case .notDetermined,.restricted,.denied:
                print("On Declined")
                return false
            @unknown default:
                return false
            }
        } else {
            return false
        }
        
    }
    
    
    public func requestTrackingAccess(onGranted: (() -> Void)? = nil,onDecline: (() -> Void)? = nil) -> Void {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { status in
                
                print(status.rawValue)
                switch status {
                case .authorized:
                    print("Log: ATTrackingManager request successful")
                    onGranted?()
                case .denied,
                        .notDetermined,
                        .restricted:
                    onDecline?()
                    break
                @unknown default:
                    break
                }
            }
        }
    }
    
    public func getTrackingIdentifier() -> UUID? {
        if(self.isTrackingAccessAvailable())
        {
            return ASIdentifierManager.shared().advertisingIdentifier
        }
        return nil
    }
}