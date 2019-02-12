//
//  ResturantViewController.swift
//  FoodFinder
//
//  Created by A.Askar on 2/7/19.
//  Copyright © 2019 A.Askar. All rights reserved.
//

import UIKit

class ResturantViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar : UISearchBar?

    lazy var viewModel: ResturantViewModel = {
        return ResturantViewModel()
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupView()
        initViewModel()
    }
    
    func setupView() {
        // Setup the Search Controller
        searchBar?.delegate = self
        
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    func initViewModel() {
        
        viewModel.showAlertClosure = { [weak self] () in
            guard let strSelf = self else { return }
            DispatchQueue.main.async {
                strSelf.showAlert(message: strSelf.viewModel.alertMessage!)
            }
        }
        
        viewModel.reloadTableViewClosure = { [weak self] () in
            guard let strSelf = self else { return }
            DispatchQueue.main.async {
                strSelf.tableView.reloadData()
            }
        }
        
        viewModel.sortValue = .bestMatch
    }
    
    private func showAlert(message: String) {
        self.presentAlert(withTitle: "Error", message: message)
    }
    
    @IBAction func filterResturants(_ sender: Any) {
        let filterView = self.instantiateViewController(identifier: String(describing: FilterViewController.self)) as! FilterViewController
        filterView.selectedSortValue = viewModel.sortValue
        filterView.didSelectSortValue = { [weak self] sortValue in
            guard let strSelf = self else { return }
            strSelf.viewModel.sortValue = sortValue
        }
        let filterNavigation = UINavigationController.init(rootViewController: filterView)
        self.present(filterNavigation, animated: true, completion: nil)
    }
}

extension ResturantViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ResturantCell.self), for: indexPath) as? ResturantCell else {
            fatalError("Cell not exists in storyboard")
        }

        let resturant = viewModel.getResturantModel(at: indexPath)
        
        cell.resturantName.text = resturant.name
        cell.openingState.text = resturant.status
        cell.sortValue.text = viewModel.sortValue.rawValue
        if let isfavorite = resturant.isFavorite {
            cell.favoriteBtn.isSelected = isfavorite
        }
        cell.didFavoriteResturant = { [weak self] (isFavorite) in
            guard let strSelf = self else { return }
            isFavorite ? strSelf.viewModel.favoriteResturant(at: indexPath) : strSelf.viewModel.unfavoriteResturant(at: indexPath)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
}

extension ResturantViewController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            viewModel.searchResutrants(.empty)
        }
        else{
            viewModel.searchResutrants(.search(searchBar.text!))
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.searchResutrants(.search(searchBar.text!))
        searchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.searchResutrants(.empty)
        searchBar.text = ""
        searchBar.endEditing(true)
    }
}

enum SearchResult {
    case search(String)
    case empty
}





