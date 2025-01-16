//
//  keychain.swift
//  MultiAdsInterface
//
//  Created by Khusnud Zehra on 17/01/25.
//

import Security
import Foundation

class KeyChain {
    static func insertToken(key: String, data: String) -> OSStatus {
        let query = [
            kSecClass as String       : kSecClassGenericPassword as String,
            kSecAttrAccount as String : key,
            kSecValueData as String   : data ] as [String : Any]

        SecItemDelete(query as CFDictionary)

        return SecItemAdd(query as CFDictionary, nil)
    }
    
    static func getToken(key: String) -> String? {
       let query = [
           kSecClass as String       : kSecClassGenericPassword,
           kSecAttrAccount as String : key,
           kSecReturnData as String  : kCFBooleanTrue ?? false,
           kSecMatchLimit as String  : kSecMatchLimitOne ] as [String : Any]

       var dataTypeRef: AnyObject? = nil

       let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

       if status == noErr {
           return dataTypeRef as! String?
       } else {
           return nil
       }
   }
}
