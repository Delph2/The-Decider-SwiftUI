//
//  ContentView.swift
//  The Decider-SwiftUI
//
//  Created by Andrew Brown on 1/23/24.
//

import SwiftUI
import SwiftData

struct GrowingButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(.blue)
            .foregroundStyle(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct ContentView: View {
    
    @Environment(\.modelContext) private var context
    
    @Query var items: [DataItemx]

    @State var deciderText = "" //DeciderNames.currentDecider.deciderName.rawValue
    
/*    init() {
            self.initiateDeciderText()
        }
*/
    var body: some View {
        
        VStack{
            Spacer()
           Text("\(deciderText)")
                .font(Font.largeTitle.weight(.bold))
                .padding(50)
                .foregroundColor(.blue)
                .frame(width: 200)
                .background(.yellow)
                .cornerRadius(20.0, antialiased: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                .onAppear {
                    print("onAppear")
                    self.initiateDeciderText()
                }
            Spacer()
            Button("Go to next Decider") {
                print("Go to next Decider pushed")
                updateDecider()
            }
            .offset(CGSize(width: 0.0, height: -30))
            .font(Font.title)
            .buttonStyle(GrowingButton())
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

    func updateDecider() {
 
        print("Start updateDecider() = \(items.count))")
        for element in items {
            print(element.name)
        }
        switch  items.first?.name {
        case "Andy":
            print("in Andy")
            DeciderNames.currentDecider.deciderName = .Gary
            deciderText = DeciderNames.currentDecider.deciderName.rawValue
            
        case "Gary":
            print("in Gary")
            DeciderNames.currentDecider.deciderName = .Sue
            deciderText = DeciderNames.currentDecider.deciderName.rawValue
            
        case "Sue":
            print("in Sue")
            DeciderNames.currentDecider.deciderName = .Sherri
            deciderText = DeciderNames.currentDecider.deciderName.rawValue
            
        case "Sherri":
            print("in Sherri")
            DeciderNames.currentDecider.deciderName = .Andy
            deciderText = DeciderNames.currentDecider.deciderName.rawValue
            
        default:
            print("Error in Switch")
        }
        print("rawvalue = \(DeciderNames.currentDecider.deciderName.rawValue)")
        
        for element in items {
            print(element.name)
        }
        if items.isEmpty {
            storeItem()
        } else {
            updateDataItem(items.first!)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.001) {
            print("End updateDecider() = \(items.count))")
            for element in items {
                print(element.name)
            }
        }
    }

     func updateDataItem(_ item: DataItemx) {
         print("in updateDataItem()")
         // Edit item data
         item.name = DeciderNames.currentDecider.deciderName.rawValue
         // Save the context
         try? context.save()
     }
    
    func storeItem() {
        print("in storeitem")
        // Create the item
        let item = DataItemx(name: DeciderNames.currentDecider.deciderName.rawValue)
        // Add the item to the data context
        context.insert(item)
        print("storeItem = \(item.name)")
    }
    
    func deleteItem(_ item: DataItemx) async -> Int {
        print("count = \(items.count)")
        context.delete(item)
        let itemCount = items.count
        return itemCount
    }

    
    func initiateDeciderText() {
        print("Start initiateDeciderText() = \(items.count))")
        for element in items {
            print(element.name)
        }
        var deciderName = ""
        if items.isEmpty {
            print("items.isEmpty")
            deciderName = "Gary"
            deciderText = "Gary"
            
        } else {
            print("else items.isEmpty")
            deciderName = items.first!.name
            deciderText = items.first!.name
            print("deciderName = \(deciderName)")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.001) {
                print("items.count = \(items.count)")
                for element in items {
                    print(element.name)
                }
            }
        }
    }

}

#Preview {
    ContentView()
}
