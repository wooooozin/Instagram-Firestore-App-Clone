//
//  UploadPostController.swift
//  InstagramFirestoreApp
//
//  Created by 효우 on 2023/01/03.
//

import UIKit

class UploadPostController: UIViewController {
    
    // MARK: - Properties
    
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
                                                            action: #selector(didTapDone) )
    }
    
    @objc func didTapCancel() {
        dismiss(animated: true)
    }
    
    @objc func didTapDone() {
        print("Done")
    }
}
