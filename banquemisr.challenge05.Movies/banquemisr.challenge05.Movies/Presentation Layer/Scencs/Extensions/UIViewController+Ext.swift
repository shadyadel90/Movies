//
//  UIViewController+Ext.swift
//  banquemisr.challenge05.Movies
//
//  Created by Shady Adel on 29/09/2024.
//

import UIKit

extension UITableViewController{
    func presentErrorAlert(message: String) {
            let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
}
