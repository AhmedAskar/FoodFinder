//
//  FavoriteManager.swift
//  FoodFinder
//
//  Created by A.Askar on 2/10/19.
//  Copyright © 2019 A.Askar. All rights reserved.
//

import Foundation

class FavoriteManager {
    
    static func getFavoriteResturants(resturants: [Resturant]) -> [Resturant] {
        let favorites = resturants.filter({StorageHelper.fileExists($0.name, in: StorageHelper.Directory.documents)})
        return favorites.map {  var resturant = $0
            resturant.isFavorite = true
            return resturant
        }
    }
    
    static func getUnFavoriteResturants(resturants: [Resturant]) -> [Resturant] {
        let unfavorites = resturants.filter({!StorageHelper.fileExists($0.name, in: StorageHelper.Directory.documents)})
        return unfavorites.map {  var resturant = $0
            resturant.isFavorite = false
            return resturant
        }
    }
    
    static func addResturant(_ resturant: Resturant) {
        do {
            try StorageHelper.store(resturant, to: .documents, as: resturant.name)
        } catch {
            print(error)
        }
    }
    
    static func removeResturant(_ resturant: Resturant) {
        do {
            try StorageHelper.remove(resturant.name, from: .documents)
        } catch {
            print(error)
        }
    }
}
