//
//  Resturant.swift
//  FoodFinder
//
//  Created by Ahmed Askar on 2/6/19.
//  Copyright © 2019 Ahmed Askar. All rights reserved.
//

import Foundation

struct Resturant: Codable {
    
    let name: String
    let status: String
    let sortingValues: SortingValue
}

enum SortingValues: String {
    case price = "Price"
    case bestMatch = "Best Match"
    case deliveryCosts = "Delivery Costs"
    case distance = "Distance"
    case minCost = "Minimum Cost"
    case newest = "Newest"
    case popularity = "Popularity"
    case ratingAverage = "Rating Average"
}

enum OpeningState: String {
    case open = "Open"
    case closed = "Closed"
    case orderAhead = "Order Ahead"
    case all = "All"
    
    var sortValue : String{
        switch self {
        case .open:
            return "open"
        case .closed:
            return "closed"
        case .orderAhead:
            return "order ahead"
        default: return ""
        }
    }
}
