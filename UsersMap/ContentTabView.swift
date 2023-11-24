//
//  ContentTabView.swift
//  UsersMap
//
//  Created by Suguru Tokuda on 11/23/23.
//

import SwiftUI

struct ContentTabView: View {
    var body: some View {
        TabView {
            PetsView()
                .tabItem { Label(
                    title: { Text("Core Data") },
                    icon: { Image(systemName: "server.rack") }
                ) }
            KeyChainView()
                .tabItem { Label(
                    title: { Text("Key Chain") },
                    icon: { Image(systemName: "key.fill") }
                ) }
            UserMapStartView()
                .tabItem { Label(
                    title: { Text("User Map") },
                    icon: { Image(systemName: "mappin") }
                ) }
        }
    }
}

#Preview {
    ContentTabView()
}
