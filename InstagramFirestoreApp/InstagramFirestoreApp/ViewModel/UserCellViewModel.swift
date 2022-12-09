//
//  UserCellViewModel.swift
//  InstagramFirestoreApp
//
//  Created by 효우 on 2022/12/10.
//

import Foundation

struct UserCellViewModel {
    private let user: User
    
    var profileImageUrl: URL? {
        return URL(string: user.profileImageUrl)
    }
    
    var username: String {
        return user.username
    }
    
    var fullnmae: String {
        return user.fullname
    }
    
    init(user: User) {
        self.user = user
    }
}
