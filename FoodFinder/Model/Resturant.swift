//
//  Resturant.swift
//  FoodFinder
//
//  Created by A.Askar on 2/6/19.
//  Copyright © 2019 A.Askar. All rights reserved.
//

import Foundation

struct ResturantModel: Codable {
    let restaurants : [Resturant]
}

struct Resturant: Codable {
    var name: String
    var status: String
    var sortingValues: SortingValue
    var isFavorite: Bool? = false
    func sortValue(_ sortValue : SortingValues) -> String {
        return sortValue.rawValue
    }
}

struct SortingValue: Codable {
    let averageProductPrice : Int
    let bestMatch : Float
    let deliveryCosts : Int
    let distance : Int
    let minCost : Int
    let newest : Float
    let popularity : Float
    let ratingAverage : Float
}

enum SortingValues: String, CaseIterable {
    case bestMatch = "Best Match"
    case price = "Price"
    case deliveryCosts = "Delivery Costs"
    case distance = "Distance"
    case minCost = "Minimum Cost"
    case newest = "Newest"
    case popularity = "Popularity"
    case ratingAverage = "Rating Average"
}

enum OpeningState: String {
    case open = "open"
    case closed = "closed"
    case orderAhead = "order ahead"
}
