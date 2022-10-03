//
//  AuthService.swift
//  InstagramFirestoreApp
//
//  Created by 효우 on 2022/10/04.
//

import UIKit
import Firebase

struct AuthCredentials {
    let email: String
    let password: String
    let fullname: String
    let username: String
    let profileImage: UIImage
}

struct AuthService {
    static func registerUser(withCredential credentiolas: AuthCredentials) {
        print(credentiolas, "DEBUG")
    }
}
