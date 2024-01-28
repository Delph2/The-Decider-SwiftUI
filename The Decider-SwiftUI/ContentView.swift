//
//  ContentView.swift
//  The Decider-SwiftUI
//
//  Created by Andrew Brown on 1/23/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    var body: some View {
        

        VStack{
            Spacer()
            Text("Gary")
                .font(Font.largeTitle.weight(.bold))
                .padding(50)
                .foregroundColor(.blue)
                .frame(width: 200)
                .background(.yellow)
                .cornerRadius(20.0, antialiased: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
            
            Spacer()
            Button("Go to next Decider") {
                print("Button tapped!")
            }
            .offset(CGSize(width: 0.0, height: -30))
            .font(Font.title)
            .buttonStyle(.borderedProminent)
            .foregroundColor(.white)

            Spacer()
            Text("Text")
                .font(Font.largeTitle.weight(.semibold))
                .padding(50)
                .foregroundColor(.blue)
                .frame(width: 200)
                .background(.yellow)
                .cornerRadius(20.0, antialiased: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
            Spacer()

        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
