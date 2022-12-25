//
//  ProfileHeaderViewModel.swift
//  InstagramFirestoreApp
//
//  Created by 효우 on 2022/10/31.
//

import UIKit

struct ProfileHeaderViewModel {
    let user: User
    
    var fullname: String {
        return user.fullname
    }
    
    var profileImageUrl: URL? {
        return URL(string: user.profileImageUrl)
    }
    
    var folloButtonText: String {
        if user.isCurrentUser {
            return "Edit Profile"
        }
        return user.isFollowed ? "Following" : "Follow"
    }
    
    var followButtonBackgroundColor: UIColor {
        return user.isCurrentUser ? .white : .systemBlue
    }
    
    var foloowButtonTextColor: UIColor {
        return user.isCurrentUser ? .black : .white
    }
        
    init(user: User) {
        self.user = user
    }
}
