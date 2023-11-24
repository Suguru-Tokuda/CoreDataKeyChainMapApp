//
//  UserMapStartView.swift
//  UsersMap
//
//  Created by Suguru Tokuda on 11/24/23.
//

import SwiftUI

struct UserMapStartView: View {
    @EnvironmentObject var coordinator: MainCoordinator
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.getPage(page: .userMap)
                .navigationDestination(for: Page.self) { page in
                    coordinator.getPage(page: page)
                }
        }
    }
}

#Preview {
    UserMapStartView()
        .environmentObject(MainCoordinator())
}
