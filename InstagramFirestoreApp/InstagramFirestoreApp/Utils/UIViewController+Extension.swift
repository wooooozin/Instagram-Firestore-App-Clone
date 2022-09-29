//
//  UIViewController+Extension.swift
//  InstagramFirestoreApp
//
//  Created by 효우 on 2022/09/30.
//

import UIKit

extension UIViewController {
    func configuareGradientLayer() {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.systemPurple.cgColor, UIColor.systemBlue.cgColor]
        gradient.locations = [0, 1]
        view.layer.addSublayer(gradient)
        gradient.frame = view.frame
    }
}
