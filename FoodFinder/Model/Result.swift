//
//  Result.swift
//  FoodFinder
//
//  Created by A.Askar on 2/10/19.
//  Copyright © 2019 A.Askar. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case error(Error)
}
