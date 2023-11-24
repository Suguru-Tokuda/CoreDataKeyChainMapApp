//
//  UsersMapApp.swift
//  UsersMap
//
//  Created by Suguru Tokuda on 11/22/23.
//

import SwiftUI

@main
struct UsersMapApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentTabView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(MainCoordinator())
        }
    }
}
