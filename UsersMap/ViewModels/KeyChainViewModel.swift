//
//  KeyChainViewModel.swift
//  UsersMap
//
//  Created by Suguru Tokuda on 11/23/23.
//

import Foundation

class KeyChainViewModel: ObservableObject {
    @Published var savedInfo: String = "None"
    @Published var inputText: String = ""
    let passwordKey: String = "com.suguru.tokuda.myInfo"
    
    func saveInputData() {
        if !inputText.isEmpty {
            saveDataIntoKeyChain(value: inputText, forKey: passwordKey)
            inputText = ""
        }
    }
    
    func getData() {
        savedInfo = getDataFromKeyChain(forKey: passwordKey)
    }
    
    private func saveDataIntoKeyChain(value: String, forKey: String) {
        if let rawData = value.data(using: .utf8) {
            let query: [String : Any] = [
                kSecClass as String : kSecClassGenericPassword,
                kSecAttrAccount as String : forKey,
                kSecValueData as String : rawData
            ]
            
            SecItemAdd(query as CFDictionary, nil)
        }
    }
    
    private func getDataFromKeyChain(forKey: String) -> String {
        var retVal = ""
        let query: [String : Any] = [
            kSecClass as String : kSecClassGenericPassword,
            kSecAttrAccount as String : forKey,
            kSecReturnData as String : kCFBooleanTrue!,
            kSecMatchLimit as String : kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject?
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        if status == noErr {
            if let data = dataTypeRef as? Data,
               let result = String(data: data, encoding: .utf8) {
                retVal = result
            }
        }
        
        return retVal
    }
}
