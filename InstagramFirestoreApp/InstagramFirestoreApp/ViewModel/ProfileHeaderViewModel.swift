//
//  ProfileHeaderViewModel.swift
//  InstagramFirestoreApp
//
//  Created by 효우 on 2022/10/31.
//

import Foundation

struct ProfileHeaderViewModel {
    let user: User
    
    var fullname: String {
        return user.fullname
    }
    
    var profileImageUrl: URL? {
        return URL(string: user.profileImageUrl)
    }
        
    init(user: User) {
        self.user = user
    }
}
