//
//  CustomTextField.swift
//  InstagramFirestoreApp
//
//  Created by 효우 on 2022/09/29.
//

import UIKit

class CustomTextField: UITextField {
    init(placeholer: String) {
        super.init(frame: .zero)
        
        let spacer = UIView()
        spacer.setDimensions(height: 50, width: 12)
        leftView = spacer
        leftViewMode = .always
        
        borderStyle = .none
        textColor = .white
        keyboardAppearance = .dark
        backgroundColor = UIColor(white: 1, alpha: 0.1)
        setHeight(50)
        attributedPlaceholder = NSAttributedString(
            string: placeholer,
            attributes: [.foregroundColor: UIColor(white: 1, alpha: 0.7)]
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
