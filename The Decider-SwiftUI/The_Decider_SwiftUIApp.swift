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
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: DataItemx.self)
    }
}
