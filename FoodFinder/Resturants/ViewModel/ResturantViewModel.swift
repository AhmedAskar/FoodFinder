//
//  ResturantViewModel.swift
//  FoodFinder
//
//  Created by A.Askar on 2/7/19.
//  Copyright © 2019 A.Askar. All rights reserved.
//

import Foundation

class ResturantViewModel {
    
    let dataSource: ResturantDataSourceProtocol
    
    var resturants: [Resturant] = [Resturant]() //for cache
    
    var resturantModels: [Resturant] = [Resturant]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    
    var sortValue: SortingValues = .bestMatch {
        didSet {
            getResturant(option: sortValue)
        }
    }

    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }
    
    var reloadTableViewClosure: (()->())?
    var showAlertClosure: (()->())?
    var updateLoadingStatus: (()->())?
    
    var numberOfCells: Int {
        return resturantModels.count
    }
    
    init(dataSource: ResturantDataSourceProtocol = ResturantDataSource()) {
        self.dataSource = dataSource
    }
    
    func getResturant(option: SortingValues) {
        DispatchQueue.global(qos: .userInitiated).async {
            self.dataSource.getFilteredResturants(option) { [weak self] (result) in
                guard let strSelf = self else { return }
                switch result {
                case .success(let resturants):
                    strSelf.resturantModels = resturants
                    strSelf.resturants = resturants
                case .error(let error):
                    strSelf.alertMessage = error.localizedDescription
                }
            }
            
        }
    }
    
    func getResturantModel(at indexPath: IndexPath) -> Resturant {
        return resturantModels[indexPath.row]
    }
    
    func searchResutrants(_ resultType: SearchResult) {
        switch resultType {
        case .search(let searchText):
            resturantModels = resturants.filter{$0.name.lowercased().hasPrefix(searchText.lowercased())}
        case .empty:
            resturantModels = resturants
        }
    }
}

extension ResturantViewModel {
    func favoriteResturant(at indexPath: IndexPath) {
        FavoriteManager.addResturant(resturantModels[indexPath.row])
        getResturant(option: self.sortValue)
    }
    
    func unfavoriteResturant(at indexPath: IndexPath) {
        FavoriteManager.removeResturant(resturantModels[indexPath.row])
        getResturant(option: self.sortValue)
    }
}
