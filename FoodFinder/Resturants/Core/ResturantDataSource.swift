//
//  ResturantDataSource.swift
//  FoodFinder
//
//  Created by A.Askar on 2/10/19.
//  Copyright © 2019 A.Askar. All rights reserved.
//

import Foundation

protocol ResturantDataSourceProtocol {
    func getFilteredResturants(_ sortValue: SortingValues, completion: @escaping(Result<[Resturant]>)->())
}

class ResturantDataSource : ResturantDataSourceProtocol {
    
    let sortLib: Sortable!
    init(sortLib: Sortable = SortLibrary()) {
        self.sortLib = sortLib
    }
    
    func getFilteredResturants(_ sortValue: SortingValues, completion: @escaping(Result<[Resturant]>)->()) {
        do {
            let allResturants = try getAllResturants()
            let favorites = FavoriteManager.getFavoriteResturants(resturants: allResturants)
            if favorites.count > 0 {
                
                let nonFavorites = FavoriteManager.getUnFavoriteResturants(resturants: allResturants)
//                let nonFavorites2 = allResturants.filter { (resturant) -> Bool in
//                    print(resturant.name)
//                    let contains = favorites.contains(where: { (rest) -> Bool in
//                        print(rest.name)
//                       return  rest.name != resturant.name
//                    })
//                    return contains
//                }
                var result = [Resturant]()
                let sortedFavorite = sortLib.sort(favorites, sortValue)
                let sortedNonFavorite = sortLib.sort(nonFavorites, sortValue)
                result.append(contentsOf: sortedFavorite)
                result.append(contentsOf: sortedNonFavorite)
                completion(Result.success(result))
            }else{
                completion(Result.success(sortLib.sort(allResturants, sortValue)))
            }
        } catch {
            completion(Result.error(error))
        }
    }
    
    private func getAllResturants() throws -> [Resturant] {
        do {
            let result: ResturantModel = try ParserHelper.parseJson("sample")
            return result.restaurants
        } catch {
            throw error
        }
    }
}
