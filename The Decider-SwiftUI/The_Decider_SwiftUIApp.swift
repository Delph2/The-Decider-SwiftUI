//
//  The_Decider_SwiftUIApp.swift
//  The Decider-SwiftUI
//
//  Created by Andrew Brown on 1/23/24.
//

import SwiftUI
import SwiftData

@main
struct The_Decider_SwiftUIApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
