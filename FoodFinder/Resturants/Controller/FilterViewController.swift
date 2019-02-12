//
//  FilterViewController.swift
//  FoodFinder
//
//  Created by A.Askar on 2/9/19.
//  Copyright © 2019 A.Askar. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    let sortingValues = SortingValues.allCases
    
    var selectedSortValue: SortingValues = .bestMatch
    
    var didSelectSortValue: ((SortingValues)->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "Filter"
    }
}

extension FilterViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if selectedSortValue == sortingValues[indexPath.row] {
            cell.accessoryType = .checkmark
        }
        cell.textLabel?.text = sortingValues[indexPath.row].rawValue
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortingValues.count
    }
}

extension FilterViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedSortValue = sortingValues[indexPath.row]
        tableView.reloadData()
        didSelectSortValue?(selectedSortValue)
        dismiss(animated: true, completion: nil)
    }
}
