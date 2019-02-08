//
//  SortingValue.swift
//  FoodFinder
//
//  Created by Ahmed Askar on 2/6/19.
//  Copyright © 2019 Ahmed Askar. All rights reserved.
//

import Foundation

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
