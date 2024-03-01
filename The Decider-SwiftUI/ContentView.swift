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
           Text("\(deciderText)")
                .font(Font.largeTitle.weight(.bold))
                .padding(50)
                .foregroundColor(.blue)
                .frame(width: 200)
                .background(.yellow)
                .cornerRadius(20.0, antialiased: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                .onAppear {
                    print("onAppear deciderText")
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
            Text("\(restaurantText)")
                .padding(40)
                .font(.system(size: 500))
                .minimumScaleFactor(0.01)
                .foregroundColor(.blue)
                .frame(width: 200, alignment: .center)
                .background(.yellow)
                .cornerRadius(20.0, antialiased: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
         
                .onAppear {
                    print("onAppear restaurantText")
                    restaurantText = selectARestaurant()
                    if !items.isEmpty {
                        updateDataItemRecent(items.first!)
                        
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.001) {
                        print("End onAppear restaurantText = \(items.count))")
                        for element in items {
                            print(element.recent)
                        }
                    }
                }
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
            DeciderNames.currentDecider.deciderName = .Sue
            deciderText = DeciderNames.currentDecider.deciderName.rawValue
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
        if items.isEmpty {
            print("items.isEmpty")
            DeciderNames.currentDecider.deciderName = .Gary
            deciderText = "Gary"
            
        } else {
            print("else items.isEmpty")
            deciderText = items.first!.name
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.001) {
                print("items.count = \(items.count)")
                for element in items {
                    print(element.name)
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
        print("in updateDataItem()")
        // Edit item data
        item.recent.append(RestaurantNames.todaysRestaurant)
        // Save the context
        try? context.save()
    }
}

#Preview {
    ContentView()
}
