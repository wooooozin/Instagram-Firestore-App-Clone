//
//  User.swift
//  InstagramFirestoreApp
//
//  Created by 효우 on 2022/10/31.
//

import Foundation
import Firebase

struct User {
    let email: String
    let fullname: String
    let profileImageUrl: String
    let username: String
    let uid: String
    
    var stats: UserStats!
    var isFollowed = false
    var isCurrentUser: Bool { return Auth.auth().currentUser?.uid == uid }
    
    init(dictionary: [String: Any]) {
        self.email = dictionary["email"] as? String ?? ""
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
        
        self.stats = UserStats(followers: 0, following: 0)
    }
}

struct UserStats {
    let followers: Int
    let following: Int
//    let posts: Int
}
