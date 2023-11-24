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
    var user: User?
    
    func startCoordinator() {
        path.append(Page.userMap)
    }
    
    func goToUserDetailsView(user: User) {
        self.user = user
        path.append(Page.userDetails)
    }
    
    @ViewBuilder
    func getPage(page: Page) -> some View {
        switch page {
        case .userMap:
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
    case userMap, userDetails
    
    var id: String { self.rawValue }
}
