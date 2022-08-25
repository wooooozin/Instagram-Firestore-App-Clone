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

    // MARK: - Extension Methods

extension MainTabController {
    
    func configureViewControllers() {
        view.backgroundColor = .systemBackground
        
        let feedVC = FeedController()
        let searchVC = SearchController()
        let imageSelectorVC = ImageSelectorController()
        let notificationVC = NotificationController()
        let profileVC = ProfileController()
        
        viewControllers = [feedVC, searchVC, imageSelectorVC, notificationVC, profileVC]
    }
    
}
