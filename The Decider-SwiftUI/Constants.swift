//
//  Constants.swift
//  The Decider-SwiftUI
//
//  Created by Andrew Brown on 1/28/24.
//

import Foundation
import SwiftUI
import UIKit

/*
 
 enum Status: Codable {
     case active
     case inactive(reason: String)
 }

 */
/*
 enum ItemType: Int, Codable {
     case foo = 0
     case bar = 1
 }
 */
/*
// the differnt names of the deciders
enum Deciders : String, Codable {

case Andy = "Andy"
case Gary = "Gary"
case Sue = "Sue"
case Sherri = "Sherri"

}
 */

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
 /*
 required init(coder aDecoder: NSCoder) {
 
 self.deciderName = Deciders(rawValue: aDecoder.decodeObject(forKey: deciderNames) as! String)!
 }
 
 func encode(with aCoder: NSCoder) {
 
 aCoder.encode(deciderName.rawValue, forKey: deciderNames)
 }
 }
 
 
 fileprivate let recentRestaurants = "recentRestaurants"
 
 class RestaurantList: NSObject, NSSecureCoding {
 
 static var supportsSecureCoding: Bool = true
 
 static var restaurantList = RestaurantList()
 
 // the differnt names of the restaurants
 enum Restaurant : String, CaseIterable, Codable {
 
 case Massimos = "Massimo's"
 case Jacks = "Jack's"
 case Lazy_Dog = "Lazy Dog"
 case El_Patio = "El Patio"
 case PF_Changs = "PF Chang's"
 case The_Counter = "The Counter"
 case DeAfghanan_Cuisine = "DeAfghanan Cuisine"
 case Banana_Leaf = "Banana Leaf"
 case Fish_Market = "Fish Market"
 case Nijo_Castle = "Nijo Castle"
 
 }
 
 static var todaysRestaurant : RestaurantList.Restaurant? = nil
 
 var recentRestaurantsList : [String]
 
 override init() {
 
 recentRestaurantsList = []
 
 super.init()
 }
 
 func encode(with aCoder: NSCoder) {
 
 aCoder.encode(recentRestaurantsList, forKey: recentRestaurants)
 }
 
 required init?(coder aDecoder: NSCoder) {
 
 self.recentRestaurantsList =  aDecoder.decodeObject(forKey: recentRestaurants) as? [String] ?? []
 
 }
 }
 */
