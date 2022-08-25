//
//  MainTabController.swift
//  InstagramFirestoreApp
//
//  Created by 효우 on 2022/08/25.
//

import UIKit

class MainTabController: UITabBarController {
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewControllers()
    }
    
}

    // MARK: - Methods

extension MainTabController {
    
    func configureViewControllers() {
        view.backgroundColor = .systemBackground
        
        let feedVC = templateNavigationController(
            unselectedImage: #imageLiteral(resourceName: "home_unselected"),
            selectedImage: #imageLiteral(resourceName: "home_selected"),
            rootViewController: FeedController()
        )
        let searchVC = templateNavigationController(
            unselectedImage: #imageLiteral(resourceName: "search_unselected"),
            selectedImage: #imageLiteral(resourceName: "search_selected"),
            rootViewController: SearchController()
        )
        let imageSelectorVC = templateNavigationController(
            unselectedImage: #imageLiteral(resourceName: "plus_unselected"),
            selectedImage: #imageLiteral(resourceName: "plus_unselected"),
            rootViewController: ImageSelectorController()
        )
        let notificationVC = templateNavigationController(
            unselectedImage: #imageLiteral(resourceName: "like_unselected"),
            selectedImage: #imageLiteral(resourceName: "like_selected"),
            rootViewController: NotificationController()
        )
        let profileVC = templateNavigationController(
            unselectedImage: #imageLiteral(resourceName: "profile_unselected"),
            selectedImage: #imageLiteral(resourceName: "profile_selected"),
            rootViewController: ProfileController()
        )
        
        viewControllers = [feedVC, searchVC, imageSelectorVC, notificationVC, profileVC]
        tabBar.tintColor = .black
    }
    
    func templateNavigationController(
        unselectedImage: UIImage,
        selectedImage: UIImage,
        rootViewController: UIViewController
    ) -> UINavigationController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.image = unselectedImage
        navigationVC.tabBarItem.selectedImage = selectedImage
        navigationVC.navigationBar.tintColor = .black
        return navigationVC
    }
    
}
