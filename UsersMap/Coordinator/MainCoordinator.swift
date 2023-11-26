//
//  MainCoordinator.swift
//  UsersMap
//
//  Created by Suguru Tokuda on 11/24/23.
//

import Foundation
import SwiftUI

@MainActor
class MainCoordinator: ObservableObject {
    @Published var path = NavigationPath()
    @Published var userPath = NavigationPath()
    var user: User?
    
    func startCoordinator() {
        path.append(Page.tabs)
    }
    
    func goToUserDetailsView(user: User) {
        self.user = user
        userPath.append(Page.userDetails)
    }
    
    @ViewBuilder
    func getPage(page: Page) -> some View {
        switch page {
        case .tabs:
            ContentTabView()
        case .usermap:
            UserMapView()
        case .userDetails:
            if let user = self.user {
                UserDetailsView(user: user)
            } else {
                EmptyView()
            }            
        }
    }
}

enum Page: String, CaseIterable, Identifiable {
    case tabs, usermap, userDetails
    
    var id: String { self.rawValue }
}
