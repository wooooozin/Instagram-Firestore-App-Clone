//
//  ProfileController.swift
//  InstagramFirestoreApp
//
//  Created by 효우 on 2022/08/25.
//

import UIKit

class ProfileController: UICollectionViewController {
    
    // MARK: - Properties
    private let cellIdentifier = "ProfileCell"
    private let headerIdentifier = "ProfileHeader"
    private var user: User
    
    // MARK: - Lifecycle
    
    init(user: User) {
        self.user = user
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        checkIfUserIsFollowed()
        fetchUserStats()
    }
    
}

// MARK: - Method

extension ProfileController {
    func configureCollectionView() {
        navigationItem.title = user.username
        collectionView.backgroundColor = .white
        collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.register(ProfileHeader.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: headerIdentifier)
    }
    
    func checkIfUserIsFollowed() {
        UserService.checkIfUserIsFoloowed(uid: user.uid) { isFollowed in
            self.user.isFollowed = isFollowed
            self.collectionView.reloadData()
        }
    }
    
    func fetchUserStats() {
        UserService.fetchUserStats(uid: user.uid) { stats in
            self.user.stats = stats
            self.collectionView.reloadData()
            
            print(stats)
        }
    }
}

// MARK: - UICollectioViewDataSource

extension ProfileController {
    override func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return 9
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: cellIdentifier,
            for: indexPath
        ) as? ProfileCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: headerIdentifier,
            for: indexPath
        ) as? ProfileHeader else { return UICollectionReusableView() }
        
        header.delegate = self
        header.viewModel = ProfileHeaderViewModel(user: user)
        
        return header
    }
}

// MARK: - UICollectionViewDelegate

extension ProfileController {
    
}

// MARK: - UICollectionViewFlowLayout

extension ProfileController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 2) / 3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 240)
    }
}

//MARK: - ProfileHeaderDelegate
extension ProfileController: ProfileHeaderDelegate {
    func header(_ profileHeader: ProfileHeader, didTapActionButtonFor user: User) {
        if user.isCurrentUser {
            print("SHow edit")
        } else if user.isFollowed {
            UserService.unfollwUser(uid: user.uid) { error in
                self.user.isFollowed = false
                self.collectionView.reloadData()
            }
        } else {
            UserService.follow(uid: user.uid) { error in
                self.user.isFollowed = true
                self.collectionView.reloadData()
            }
        }
    }
}
