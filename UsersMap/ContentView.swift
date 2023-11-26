//
//  ContentView.swift
//  UsersMap
//
//  Created by Suguru Tokuda on 11/25/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var coordinator: MainCoordinator
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.getPage(page: .tabs)
                .navigationDestination(for: Page.self) { page in
                    coordinator.getPage(page: page)
                }
        }
    }
}

#Preview {
    ContentView()
}
