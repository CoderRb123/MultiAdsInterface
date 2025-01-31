//
//  AppTrans.swift
//  MultiAdsInterface
//
//  Created by Khusnud Zehra on 17/01/25.
//

import AdSupport
import AppTrackingTransparency
//import UserMessagingPlatform

@available(iOS 13.0, *)
class AppTrans {
    public init() {
    }

    public func getTrackingIdentifierWithRequest() -> UUID? {
//        trackingConsentFlow {
//            print("✅ UMP FORM COMPLETED")
//        }
        var id: UUID?
        self.requestTrackingAccess {
            id =  self.getTrackingIdentifier()
        }
        return id
    }

    public func isTrackingAccessAvailable() -> Bool {
        if #available(iOS 14, *) {
            switch ATTrackingManager.trackingAuthorizationStatus {
            case .authorized:
                print("On authorized")
                return true
            case .denied:
                print("Denied")
                return false
            case .notDetermined:
                print("Not Determined")
                return false
            case .restricted:
                print("Restricted")
                return false
            @unknown default:
                return false
            }
        } else {
            return false
        }
    }

    public func requestTrackingAccess(onGranted: (() -> Void)? = nil) {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { status in
                switch status {
                case .authorized:
                    print("Log: ATTrackingManager request successful")
                    onGranted?()
                case .denied:
                    print("Denied")
                   
                case .notDetermined:
                    print("Not Determined")
                  
                case .restricted:
                    print("Restricted")
                    
                
                @unknown default:
                    print("Unknown")
                  
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
    
//    public func loadForm(_ completion: @escaping () -> Void) {
//        UMPConsentForm.load(completionHandler: { form, loadError in
//            if loadError != nil {
//                print("MYERROR #2 \(String(describing: loadError))")
//                completion()
//            } else {
//                print("CONSENT STATUS: \(UMPConsentInformation.sharedInstance.consentStatus)")
//                if UMPConsentInformation
//                    .sharedInstance.consentStatus == .required {
//                    
//                    if UMPConsentInformation
//                        .sharedInstance.consentStatus == .obtained {
//                        completion()
//                    } else {
//                        form?.present(from: rootController, completionHandler: { _ in
//                            completion()
//                        })
//                    }
//                }
//            }
//        })
//    }
//    
//    public func trackingConsentFlow(completion: @escaping () -> Void) {
//        let umpParams = UMPRequestParameters()
//        let debugSettings = UMPDebugSettings()
//        debugSettings.geography = UMPDebugGeography.EEA
//        umpParams.debugSettings = debugSettings
//        umpParams.tagForUnderAgeOfConsent = false
//
//        UMPConsentInformation
//            .sharedInstance
//            .requestConsentInfoUpdate(with: umpParams,
//             completionHandler: { error in
//             if error != nil {
//                print("MYERROR #1 \(String(describing: error))")
//                completion()
//               } else {
//                 let formStatus = UMPConsentInformation.sharedInstance.formStatus
//                 print("FORM STATUS: \(formStatus)")
//               if formStatus == .available {
//                   self.loadForm(completion)
//                 } else {
//                    completion()
//                 }
//            }
//        })
//    }

}
