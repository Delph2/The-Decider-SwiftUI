//
//  Constants.swift
//  The Decider-SwiftUI
//
//  Created by Andrew Brown on 1/28/24.
//

import Foundation
import SwiftUI
import UIKit
import GameKit

fileprivate let deciderNames = "deciderNames"

class DeciderNames: NSObject {
    
    // the differnt names of the deciders
    enum Deciders : String, Codable {
        
        case Andy = "Andy"
        case Gary = "Gary"
        case Sue = "Sue"
        case Sherri = "Sherri"
        
    }
    static var currentDecider = DeciderNames()
    
    var deciderName : Deciders
    
    
    override init() {
        
        deciderName = Deciders.Gary
        
        super.init()
    }
}

class RestaurantNames: NSObject {
    
    // the differnt names of the restaurants
    enum Restaurants : String, CaseIterable, Codable {
    
        case Massimos = "Massimo's"
        case Jacks = "Jack's"
        case Lazy_Dog = "Lazy Dog"
        case El_Patio = "El Patio"
        case Sakoons = "Sakoons"
        case The_Counter = "The Counter"
        case DeAfghanan_Cuisine = "DeAfghanan Cuisine"
        case Banana_Leaf = "Banana Leaf"
        case El_Rodeo = "El Rodeo"
        case Papillon = "Papillon"
    
    }
    static var todaysRestaurant = String()
    
    var restaurantName : Restaurants
    
    
    override init() {
        
        restaurantName = Restaurants.Jacks
        
        super.init()
    }
}
 /*
import GameKit

func chooseRestaurant() {

    print("in chooseRestaurant() ")
    selectARestaurant()
    if RestaurantList.todaysRestaurant == nil {
        
        RestaurantList.todaysRestaurant = RestaurantList.Restaurant.Jacks
    }
    var matchesRecent = checkForRecentRestaurantMatch(selectedRestaurant : RestaurantList.todaysRestaurant!.rawValue)
    while matchesRecent {
        
        selectARestaurant()
        matchesRecent = checkForRecentRestaurantMatch(selectedRestaurant : RestaurantList.todaysRestaurant!.rawValue)
    }
    RestaurantList.restaurantList.recentRestaurantsList.append(RestaurantList.todaysRestaurant!.rawValue)
    if RestaurantList.restaurantList.recentRestaurantsList.count > 5 {
        
        RestaurantList.restaurantList.recentRestaurantsList.remove(at: 0)
    }
    print("list = \(RestaurantList.restaurantList.recentRestaurantsList)")
}

func checkForRecentRestaurantMatch(selectedRestaurant : String) -> Bool {
    
    
    print("in checkForRecentRestaurantMatch: \(selectedRestaurant)")
    var foundRestaurant = false
    if RestaurantList.restaurantList.recentRestaurantsList.count <= 1 {
        
        return false
    }
    for index in 0...(RestaurantList.restaurantList.recentRestaurantsList.count - 1) {
        
        let checkRestaurant = RestaurantList.restaurantList.recentRestaurantsList[index]
        if checkRestaurant == selectedRestaurant {
            
            foundRestaurant = true
        }
    }
    return foundRestaurant
}
*/
