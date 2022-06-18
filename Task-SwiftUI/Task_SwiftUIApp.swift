//
//  Task_SwiftUIApp.swift
//  Task-SwiftUI
//
//  Created by hakkı can şengönül on 17.06.2022.
//

import SwiftUI

@main
struct Task_SwiftUIApp: App {
    let persistenceController = PersistenceController.shared
    @AppStorage("isDarkMode") private var isDarkMode : Bool = false
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
