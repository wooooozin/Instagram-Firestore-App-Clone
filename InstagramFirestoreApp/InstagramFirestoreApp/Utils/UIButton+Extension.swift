//
//  UIButton+Extension.swift
//  InstagramFirestoreApp
//
//  Created by 효우 on 2022/09/29.
//

import UIKit

extension UIButton {
    func attributedTitle(firstPart: String, seconPart: String) {
        let atts: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(white: 1, alpha: 0.87),
            .font: UIFont.systemFont(ofSize: 16)
        ]
        let attributedTitle = NSMutableAttributedString(string: "\(firstPart) ", attributes: atts)
        let boldAtts: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(white: 1, alpha: 0.87),
            .font: UIFont.boldSystemFont(ofSize: 16)
        ]
        attributedTitle.append(NSAttributedString(string: "\(seconPart)", attributes: boldAtts))
        setAttributedTitle(attributedTitle, for: .normal)
    }
}
