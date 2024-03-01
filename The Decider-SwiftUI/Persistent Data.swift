//
//  Persistent Data.swift
//  The Decider-SwiftUI
//
//  Created by Andrew Brown on 1/31/24.
//

import Foundation
import SwiftData

@Model
class   DataItemx: Identifiable {

    var name: String
    var recent: [String]
    
    init(name: String) {
        
        self.name = name
        self.recent = []
    }
}
