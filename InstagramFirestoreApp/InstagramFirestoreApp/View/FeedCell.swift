//
//  FeedCell.swift
//  InstagramFirestoreApp
//
//  Created by 효우 on 2022/08/26.
//

import UIKit

class FeedCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    private let profileImageVIew: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(named: "venom-7")
        return imageView
    }()
    
    private lazy var userNameButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitle("venom", for: .normal)
        button.addTarget(self, action: #selector(didTapUserName), for: .touchUpInside)
        return button
    }()
    
    private let postImageVIew: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(named: "venom-7")
        return imageView
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "like_unselected"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private lazy var commentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "comment"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private lazy var sharedButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "send2"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private let likesLabel: UILabel = {
        let label = UILabel()
        label.text = "1 likes"
        label.font = UIFont.boldSystemFont(ofSize: 13)
        return label
    }()
    
    private let captionLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello my insta"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let postTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "2 days ago"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConfigureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    @objc func didTapUserName() {
        print("didTapUserName")
    }
}

    // MARK: - Methods

extension FeedCell {
    func setConfigureUI() {
        backgroundColor = .white
        
        addSubview(profileImageVIew)
        profileImageVIew.anchor(
            top: topAnchor,
            left: leftAnchor,
            paddingTop: 12,
            paddingLeft: 12
        )
        profileImageVIew.setDimensions(height: 40, width: 40)
        profileImageVIew.layer.cornerRadius = 40 / 2
        
        addSubview(userNameButton)
        userNameButton.centerY(
            inView: profileImageVIew,
            leftAnchor: profileImageVIew.rightAnchor,
            paddingLeft: 8
        )
        
        addSubview(postImageVIew)
        postImageVIew.anchor(
            top: profileImageVIew.bottomAnchor,
            left: leftAnchor,
            right: rightAnchor,
            paddingTop: 8
        )
        postImageVIew.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        
        setConfigureButtons()
        
        addSubview(likesLabel)
        likesLabel.anchor(
            top: likeButton.bottomAnchor,
            left: leftAnchor,
            paddingTop: -4,
            paddingLeft: 8
        )
        
        addSubview(captionLabel)
        captionLabel.anchor(
            top: likesLabel.bottomAnchor,
            left: leftAnchor,
            paddingTop: 8,
            paddingLeft: 8
        )
        
        addSubview(postTimeLabel)
        postTimeLabel.anchor(
            top: captionLabel.bottomAnchor,
            left: leftAnchor,
            paddingTop: 8,
            paddingLeft: 8
        )
    }
    
    func setConfigureButtons() {
        let stackView = UIStackView(arrangedSubviews: [likeButton, commentButton, sharedButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        stackView.anchor(top: postImageVIew.bottomAnchor, width: 120, height: 50)
    }
}
