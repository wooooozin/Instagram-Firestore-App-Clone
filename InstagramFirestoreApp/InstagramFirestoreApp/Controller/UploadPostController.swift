//
//  UploadPostController.swift
//  InstagramFirestoreApp
//
//  Created by 효우 on 2023/01/03.
//

import UIKit

class UploadPostController: UIViewController {
    
    // MARK: - Properties
    
    private let photoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(systemName: "person.fill")
        iv.clipsToBounds = true
        return iv
    }()
    
    private let captionTextView: UITextView = {
        let tv = UITextView()
        return tv
    }()
    
    private let characterCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "0/100"
        return label
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
}

// MARK: - Methods

extension UploadPostController {
    func configureUI() {
        view.backgroundColor = .white
        navigationItem.title = "Upload Post"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                           target: self,
                                                           action: #selector(didTapCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapDone))
        
        view.addSubview(photoImageView)
        photoImageView.setDimensions(height: 180, width: 180)
        photoImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 8)
        photoImageView.centerX(inView: view)
        photoImageView.layer.cornerRadius = 10

        view.addSubview(captionTextView)
        captionTextView.anchor(top: photoImageView.bottomAnchor,
                               left: view.leftAnchor,
                               right: view.rightAnchor,
                               paddingTop: 16,
                               paddingLeft: 12,
                               paddingRight: 12,
                               height: 64)
        
        view.addSubview(characterCountLabel)
        characterCountLabel.anchor(bottom: captionTextView.bottomAnchor,
                                   right: view.rightAnchor,
                                   paddingRight: 12)
    }
    
    @objc func didTapCancel() {
        dismiss(animated: true)
    }
    
    @objc func didTapDone() {
        print("Done")
    }
}
