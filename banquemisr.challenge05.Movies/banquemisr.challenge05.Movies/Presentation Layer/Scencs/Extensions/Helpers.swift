import UIKit

class Helpers {

    static func configureTabBarAppearance(for tabBarItem: UITabBarItem) {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .systemIndigo
        tabBarItem.standardAppearance = appearance
    }
    
    
    static func convertGenreIdsToString(ids: [Int]) -> String? {
        guard !ids.isEmpty else { return "Unknown" }
        
        let genreNames = ids.compactMap { Constants.genres[$0] ?? "Unknown Genre" }
        return genreNames.joined(separator: ", ")
    }
    
}
