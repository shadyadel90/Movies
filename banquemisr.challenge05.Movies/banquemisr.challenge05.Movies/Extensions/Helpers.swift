//
//  Helpers.swift
//  banquemisr.challenge05.Movies
//
//  Created by Shady Adel on 27/09/2024.
//

import UIKit

class Helpers {
    
   static func configureTabBarAppearance(for tabBarItem: UITabBarItem) {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .systemIndigo
        tabBarItem.standardAppearance = appearance
    }
    
    static func convertGenreIdsToString(ids: [Int]) -> String {
        let genreNames = ids.compactMap { Constants.genres[$0] }
        return genreNames.joined(separator: ", ")
    }
    
}
