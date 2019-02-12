//
//  ResturantCell.swift
//  FoodFinder
//
//  Created by A.Askar on 2/8/19.
//  Copyright © 2019 A.Askar. All rights reserved.
//

import UIKit

class ResturantCell: UITableViewCell {

    @IBOutlet weak var favoriteBtn: UIButton!
    @IBOutlet weak var resturantName: UILabel!
    @IBOutlet weak var openingState: UILabel!
    @IBOutlet weak var sortValue: UILabel!
    
    var didFavoriteResturant: ((Bool)->())?

    @IBAction func favorite(_ sender: Any) {    
        didFavoriteResturant?(!favoriteBtn.isSelected)
    }
}
