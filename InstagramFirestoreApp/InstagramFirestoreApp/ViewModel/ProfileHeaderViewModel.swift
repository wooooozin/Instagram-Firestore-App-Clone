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
    
    var numberOfFollowers: NSAttributedString {
        return atrributedStateText(value: user.stats.followers, label: "followers")
    }
    
    var numberOfFollowing: NSAttributedString {
        return atrributedStateText(value: user.stats.following, label: "following")
    }
    
    var numberOfPost: NSAttributedString {
        return atrributedStateText(value: 10, label: "posts")
    }
        
    init(user: User) {
        self.user = user
    }
    
    func atrributedStateText(value: Int, label: String) -> NSAttributedString {
        let atrributeText = NSMutableAttributedString(string: "\(value)\n", attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        atrributeText.append(NSAttributedString(string: label, attributes: [.font: UIFont.systemFont(ofSize: 14),
                                                                            .foregroundColor: UIColor.lightGray]))
        return atrributeText
    }
}
