//
//  AppTrans.swift
//  MultiAdsInterface
//
//  Created by Khusnud Zehra on 17/01/25.
//

import AdSupport
import AppTrackingTransparency

class AppTrans {
    public init() {
    }

    public func getTrackingIdentifierWithRequest() -> UUID? {
        if isTrackingAccessAvailable() {
            requestTrackingAccess {
                print("On Approved")
            } onDecline: {
                print("On Declined")
            }
            return getTrackingIdentifier()
        }

        return nil
    }

    public func isTrackingAccessAvailable() -> Bool {
        if #available(iOS 14, *) {
            switch ATTrackingManager.trackingAuthorizationStatus {
            case .authorized:
                print("On authorized")
                return true
            case .notDetermined, .restricted, .denied:
                print("On Declined")
                return false
            @unknown default:
                return false
            }
        } else {
            return false
        }
    }

    public func requestTrackingAccess(onGranted: (() -> Void)? = nil, onDecline: (() -> Void)? = nil) {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { status in

                switch status {
                case .authorized:
                    print("Log: ATTrackingManager request successful")
                    onGranted?()
                case .denied:
                    print("Denied")
                    onDecline?()
                case .notDetermined:
                    print("Not Determined")
                    onDecline?()
                case .restricted:
                    print("Restricted")
                    onDecline?()
                @unknown default:
                    print("Unknown")
                    onDecline?()
                    break
                }
            }
        }
    }

    public func getTrackingIdentifier() -> UUID? {
        if isTrackingAccessAvailable() {
            return ASIdentifierManager.shared().advertisingIdentifier
        }
        return nil
    }
}
