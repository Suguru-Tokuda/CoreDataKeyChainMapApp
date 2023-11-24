//
//  KeyChainView.swift
//  UsersMap
//
//  Created by Suguru Tokuda on 11/23/23.
//

import SwiftUI

struct KeyChainView: View {
    @StateObject var vm: KeyChainViewModel = KeyChainViewModel()
    
    var body: some View {
        VStack(alignment: .center) {
            Text(vm.savedInfo)
            
            TextField("Type Info", text: $vm.inputText)
                .frame(maxWidth: 200)
            Button("Save info into KeyChain") {
                vm.saveInputData()
            }.buttonStyle(.borderedProminent)
            
            Button("Get info from KeyChain") {
                vm.getData()
            }.buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    KeyChainView()
}
