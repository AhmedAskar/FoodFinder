//
//  ResturantDataSource.swift
//  FoodFinder
//
//  Created by Ahmed Askar on 2/6/19.
//  Copyright © 2019 Ahmed Askar. All rights reserved.
//

import Foundation

protocol ResturantDataSourceProtocol {
    func getResturants()
}

class ResturantDataSource {
    
    func getResturants() -> [Resturant] {
        do {
            let result: ResturantModel = try JSONParse.parseJson("sample")
            return result.restaurants
        } catch {
            print(error)
        }
        return []
    }

    func getFavoriteResturants(_ option: SortingValues) -> [Resturant] {
        let resturants = self.getResturants()
        let favorites = resturants.filter({StorageHelper.fileExists($0.name, in: StorageHelper.Directory.documents)})
        return sort(favorites, option)
    }
    
    func sort(_ resturants: [Resturant],_ option: SortingValues) -> [Resturant] {
        return sortbyOpeningState(sortbyOption(resturants, option))
    }
    
    func sortbyOpeningState(_ resturants: [Resturant]) -> [Resturant] {
        
        return resturants.sorted { $0.status == OpeningState.open.sortValue && $1.status == OpeningState.orderAhead.sortValue }
    }
    
    func sortbyOption(_ resturants: [Resturant],_ option: SortingValues) -> [Resturant] {
        
        switch option {
        case .price:
            return resturants.sorted{ $0.sortingValues.averageProductPrice > $1.sortingValues.averageProductPrice }
        case .bestMatch:
            return resturants.sorted{ $0.sortingValues.bestMatch > $1.sortingValues.bestMatch }
        case .deliveryCosts:
            return resturants.sorted{ $0.sortingValues.deliveryCosts > $1.sortingValues.deliveryCosts }
        case .distance:
            return resturants.sorted{ $0.sortingValues.distance > $1.sortingValues.distance }
        case .minCost:
            return resturants.sorted{ $0.sortingValues.minCost > $1.sortingValues.minCost }
        case .newest:
            return resturants.sorted{ $0.sortingValues.newest > $1.sortingValues.newest }
        case .popularity:
            return resturants.sorted{ $0.sortingValues.popularity > $1.sortingValues.popularity }
        case .ratingAverage:
            return resturants.sorted{ $0.sortingValues.ratingAverage > $1.sortingValues.ratingAverage }
        }
    }
}
