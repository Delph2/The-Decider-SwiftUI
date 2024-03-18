//
//  ContentView.swift
//  The Decider-SwiftUI
//
//  Created by Andrew Brown on 1/23/24.
//

import SwiftUI
import SwiftData
import GameKit

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

    @State var deciderText = ""
    
    @State var restaurantText = ""

    var body: some View {
        
        VStack{
            Spacer()
            Text("Tap for next decider")
            Button("\(deciderText)"){
                updateDecider()
            }
                .font(Font.largeTitle.weight(.bold))
                .lineLimit(1)
                .foregroundColor(.blue)
                .frame(width: 200, height: 150, alignment: .center)
                .background(.yellow)
                .cornerRadius(20.0, antialiased: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                .buttonStyle(.plain)
                .onAppear {
                    self.initiateDeciderText()
                }
            Spacer()
            Spacer()
            Text("Tap for next restaraunt")
            Button("\(restaurantText)"){
                findRestaurantToDisplay()
            }
                .font(Font.largeTitle.weight(.bold))
                .minimumScaleFactor(0.01)
                .foregroundColor(.blue)
                .frame(width: 200, height: 150, alignment: .center)
                .background(.yellow)
                .cornerRadius(20.0, antialiased: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                .buttonStyle(.plain)
         
                .onAppear {
                    findRestaurantToDisplay()

                }
            Spacer()
 
        }
    }

    func updateDecider() {
 
 /*       print("Start updateDecider() = \(items.count))")
        for element in items {
            print(element.name)
        }
  */
        switch  items.first?.name {
        case "Andy":
            DeciderNames.currentDecider.deciderName = .Gary
            deciderText = DeciderNames.currentDecider.deciderName.rawValue
            
        case "Gary":
            DeciderNames.currentDecider.deciderName = .Sue
            deciderText = DeciderNames.currentDecider.deciderName.rawValue
            
        case "Sue":
            DeciderNames.currentDecider.deciderName = .Sherri
            deciderText = DeciderNames.currentDecider.deciderName.rawValue
            
        case "Sherri":
            DeciderNames.currentDecider.deciderName = .Andy
            deciderText = DeciderNames.currentDecider.deciderName.rawValue
            
        default:
            print("Error in Switch")
        }

        if items.isEmpty {
            DeciderNames.currentDecider.deciderName = .Sue
            deciderText = DeciderNames.currentDecider.deciderName.rawValue
            storeItem()
        } else {
            updateDataItem(items.first!)
        }
/*
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.001) {
            print("End updateDecider() = \(items.count))")
            for element in items {
                print(element.name)
            }
        }
 */
    }

     func updateDataItem(_ item: DataItemx) {
         // Edit item data
         item.name = DeciderNames.currentDecider.deciderName.rawValue
         // Save the context
         try? context.save()
     }
    
    func storeItem() {
        // Create the item
        let item = DataItemx(name: DeciderNames.currentDecider.deciderName.rawValue)
        // Add the item to the data context
        context.insert(item)
    }
    
    func deleteItem(_ item: DataItemx) async -> Int {
        context.delete(item)
        let itemCount = items.count
        return itemCount
    }

    
    func initiateDeciderText() {
        if items.isEmpty {
            DeciderNames.currentDecider.deciderName = .Gary
            deciderText = "Gary"
            
        } else {
            deciderText = items.first!.name
        }
    }
    
    func findRestaurantToDisplay() {
        restaurantText = selectARestaurant()
        var matchesRecent = checkForRecentRestaurantMatch(selectedRestaurant : restaurantText)
        while matchesRecent {
            
            restaurantText = selectARestaurant()
            matchesRecent = checkForRecentRestaurantMatch(selectedRestaurant : restaurantText)
        }
        if !items.isEmpty {
            updateDataItemRecent(items.first!)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.001) {
            for element in items {

                if element.recent.count > 5 {
                    element.recent.removeFirst()

                }
            }
        }
    }

    func selectARestaurant() -> String {

        var dieRoll = 0
        if RestaurantNames.Restaurants.allCases.count >= 1 {
            
            let dieRolls = GKRandomDistribution(lowestValue: 0, highestValue: (RestaurantNames.Restaurants.allCases.count - 1))
            dieRoll = dieRolls.nextInt()
            switch dieRoll {
            case 0: RestaurantNames.todaysRestaurant = RestaurantNames.Restaurants.DeAfghanan_Cuisine.rawValue
            case 1:
                RestaurantNames.todaysRestaurant = RestaurantNames.Restaurants.El_Patio.rawValue
            case 2:
                RestaurantNames.todaysRestaurant = RestaurantNames.Restaurants.Jacks.rawValue
            case 3:
                RestaurantNames.todaysRestaurant = RestaurantNames.Restaurants.Lazy_Dog.rawValue
            case 4:
                RestaurantNames.todaysRestaurant = RestaurantNames.Restaurants.Massimos.rawValue
            case 5:
                RestaurantNames.todaysRestaurant = RestaurantNames.Restaurants.Papillon.rawValue
            case 6:
                RestaurantNames.todaysRestaurant = RestaurantNames.Restaurants.The_Counter.rawValue
            case 7:
                RestaurantNames.todaysRestaurant = RestaurantNames.Restaurants.Banana_Leaf.rawValue
            case 8:
                RestaurantNames.todaysRestaurant = RestaurantNames.Restaurants.El_Rodeo.rawValue
            case 9:
                RestaurantNames.todaysRestaurant = RestaurantNames.Restaurants.Sakoons.rawValue
            default:
                print("ERROR in chooseRestaurant()")
            }
        }

        return RestaurantNames.todaysRestaurant
    }
    
    func updateDataItemRecent(_ item: DataItemx) {
        // Edit item data
        item.recent.append(RestaurantNames.todaysRestaurant)
        // Save the context
        try? context.save()
    }
    
    func checkForRecentRestaurantMatch(selectedRestaurant : String) -> Bool {
        
        
        print("in checkForRecentRestaurantMatch: \(selectedRestaurant)")
        
        var foundRestaurant = false
        var recentList = [String]()
        if items.isEmpty {
            return false
        } else {
             recentList = items.first!.recent
        }
        if recentList.count <= 1 {
            
            return false
        }
        for index in 0...(recentList.count - 1) {
            print("\(selectedRestaurant) = \(recentList[index])")
            let checkRestaurant = recentList[index]
            if checkRestaurant == selectedRestaurant {
                print("foundRestaurant = true")
                foundRestaurant = true
            }
        }
        return foundRestaurant
    }
}

#Preview {
    ContentView()
}
