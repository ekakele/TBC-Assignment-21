//
//  TabBarController.swift
//  Assignment-21
//
//  Created by Eka Kelenjeridze on 21.11.23.
//

import UIKit

final class TabBarController: UITabBarController {
    
    // MARK: - Properties
    private let factsViewController = MainPageViewController()
    private let breedsViewController = BreedsPageViewController()
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    // MARK: - Private Methods
    private func createNav(with title: String, and image: UIImage?, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        nav.viewControllers.first?.navigationItem.title = title
        return nav
    }
    
    private func setupTabBar() {
        let mainViewController = self.createNav(
            with: "Facts",
            and: UIImage(systemName: "text.magnifyingglass"),
            vc: factsViewController
        )
        let secondViewController = self.createNav(
            with: "Breeds",
            and: UIImage(systemName: "b.circle"),
            vc: breedsViewController
        )
        
        setViewControllers([mainViewController, secondViewController], animated: true)
        
        tabBar.tintColor = UIColor(red: 0.93, green: 0.56, blue: 0.37, alpha: 1.00)
        tabBar.unselectedItemTintColor = .systemGray
    }
}
