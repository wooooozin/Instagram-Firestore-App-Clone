//
//  MainTabController.swift
//  InstagramFirestoreApp
//
//  Created by 효우 on 2022/08/25.
//

import UIKit
import Firebase
import YPImagePicker

class MainTabController: UITabBarController {
    
    private var user: User? {
        didSet {
            guard let user = user else { return }
            configureViewControllers(withUser: user)
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfUserIsLoggedIn()
        fetchUser()
    }
}

    // MARK: - Methods

extension MainTabController {
    func configureViewControllers(withUser user: User) {
        view.backgroundColor = .white
        self.delegate = self
        
        let layout = UICollectionViewFlowLayout()
        let feedVC = templateNavigationController(
            unselectedImage: #imageLiteral(resourceName: "home_unselected"),
            selectedImage: #imageLiteral(resourceName: "home_selected"),
            rootViewController: FeedController(collectionViewLayout: layout)
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
        let profileController = ProfileController(user: user)
        let profileVC = templateNavigationController(
            unselectedImage: #imageLiteral(resourceName: "profile_unselected"),
            selectedImage: #imageLiteral(resourceName: "profile_selected"),
            rootViewController: profileController
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
    
    func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let controller = LoginController()
                let navigation = UINavigationController(rootViewController: controller)
                navigation.modalPresentationStyle = .fullScreen
                self.present(navigation, animated: true)
            }
        }
    }
    
    func fetchUser() {
        UserService.fetchUser { user in
            self.user = user
        }
    }
    
    func didFinishPickingMedia(_ picker: YPImagePicker) {
        picker.didFinishPicking { items, _ in
            picker.dismiss(animated: true) {
                guard let selectedImage = items.singlePhoto?.image else { return }
                print(selectedImage)
            }
        }
    }
}

// MARK: - AuthenticationDelegate

extension MainTabController: AuthenticationDelegate {
    func authenticationComplete() {
        fetchUser()
        self.dismiss(animated: true)
    }
}

// MARK: - UITabBarControllerDelegate

extension MainTabController: UITabBarControllerDelegate {
    func tabBarController(
        _ tabBarController: UITabBarController,
        shouldSelect viewController: UIViewController
    ) -> Bool {
        let index = viewControllers?.firstIndex(of: viewController)
        if index == 2 {
            var config = YPImagePickerConfiguration()
            config.library.mediaType = .photo
            config.shouldSaveNewPicturesToAlbum = false
            config.startOnScreen = .library
            config.screens = [.library]
            config.hidesBottomBar = false
            config.hidesStatusBar = false
            config.library.maxNumberOfItems = 1
            
            let picker = YPImagePicker(configuration: config)
            picker.modalPresentationStyle = .fullScreen
            present(picker, animated: true)
            didFinishPickingMedia(picker)
        }
        return true
    }
}

