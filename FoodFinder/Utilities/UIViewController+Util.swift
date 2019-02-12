//
//  UIViewController+Util.swift
//  FoodFinder
//
//  Created by A.Askar on 2/7/19.
//  Copyright © 2019 A.Askar. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func presentAlert(withTitle title:String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    func instantiateViewController(identifier: String) -> UIViewController {
        let controller = storyboard?.instantiateViewController(withIdentifier: identifier)
        //Forced unwrap as i wanna make sure that the controller is already instantiated
        return controller!
    }
}
