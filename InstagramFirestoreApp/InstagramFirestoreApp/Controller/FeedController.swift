//
//  FeedController.swift
//  InstagramFirestoreApp
//
//  Created by 효우 on 2022/08/25.
//

import UIKit
import Firebase

private var reuseIdentifier = "Cell"

class FeedController: UICollectionViewController {
    
    // MARK: - Properties
    private var posts = [Post]()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConfigureUI()
        fetchPost()
    }
}

    // MARK: - Methods

extension FeedController {
    func setConfigureUI() {
        collectionView.backgroundColor = .white
        collectionView.register(
            FeedCell.self,
            forCellWithReuseIdentifier: reuseIdentifier
        )
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Logout",
            style: .plain,
            target: self,
            action: #selector(handleLogout)
        )
        navigationItem.title = "Feed"
    }
    
    @objc func handleLogout() {
        do {
            try Auth.auth().signOut()
            let controller = LoginController()
            controller.delegate = self.tabBarController as? MainTabController
            let navigation = UINavigationController(rootViewController: controller)
            navigation.modalPresentationStyle = .fullScreen
            self.present(navigation, animated: true)
        } catch {
            print("Failed to sign out")
        }
    }
    
    func fetchPost() {
        PostService.fetchPosts { posts in
            self.posts = posts
            self.collectionView.reloadData()
        }
    }
}

    // MARK: - UICollectionViewDataSource

extension FeedController {
    override func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return posts.count
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: reuseIdentifier,
            for: indexPath
        ) as? FeedCell else {
            return UICollectionViewCell()
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension FeedController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = view.frame.width
        var height = width + 8 + 40 + 8
        height += 50
        height += 60
        
        return CGSize(width: width, height: height)
    }
}
