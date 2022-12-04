//
//  RegisterController.swift
//  InstagramFirestoreApp
//
//  Created by 효우 on 2022/09/29.
//

import UIKit

class RegisterController: UIViewController {
    
    // MARK: - Properties
    
    private var viewmodel = RegisterViewModel()
    private var profileImage: UIImage?
    weak var delegate: AuthenticationDelegate?
    
    private lazy var plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus_photo"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleProfilePhotoSelect), for: .touchUpInside)
        return button
    }()
    
    private let emailTextField: UITextField = {
        let tf = CustomTextField(placeholer: "Email")
        tf.keyboardType = .emailAddress
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = CustomTextField(placeholer: "Password")
        tf.textContentType = .oneTimeCode
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let fullnameTextField: UITextField = CustomTextField(placeholer: "Fullname")
    private let usernameTextField: UITextField = CustomTextField(placeholer: "Username")
    
    private lazy var alreadyDontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(firstPart: "Already have an accont?", seconPart: "Sign Up.")
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
    }()
    
    private lazy var signupButton: UIButton = {
        let button = UIButton(type: .system)
        button.setAuthenticationButton(title: "Sign Up")
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        button.setTitleColor(UIColor(white: 1, alpha: 0.67), for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.1)
        button.isEnabled = false
        return button
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNotificationObservers()
    }
    
    // MARK: - Actions
    
    @objc func handleShowSignUp() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleSignUp() {
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
              let fullname = fullnameTextField.text,
              let username = usernameTextField.text?.lowercased(),
              let profileImage = self.profileImage else { return }
        
        let credentials = AuthCredentials(
            email: email,
            password: password,
            fullname: fullname,
            username: username,
            profileImage: profileImage
        )
        
        AuthService.registerUser(withCredential: credentials) { [weak self] error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            self?.delegate?.authenticationComplete()
        }
        
    }
    
    @objc func textDidChaging(sender: UITextField) {
        if sender == emailTextField {
            viewmodel.email = sender.text
        } else if sender == passwordTextField {
            viewmodel.password = sender.text
        } else if sender == fullnameTextField {
            viewmodel.fullname = sender.text
        } else {
            viewmodel.username = sender.text
        }
        updateForm()
    }
    
    @objc func handleProfilePhotoSelect() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
}

// MARK: - Methods
extension RegisterController {
    
    func configureUI() {
        configuareGradientLayer()
        
        view.addSubview(plusPhotoButton)
        plusPhotoButton.centerX(inView: view)
        plusPhotoButton.setDimensions(height: 140, width: 140)
        plusPhotoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        
        let stackView = UIStackView(arrangedSubviews: [
            emailTextField, passwordTextField, fullnameTextField, usernameTextField, signupButton
        ])
        stackView.axis = .vertical
        stackView.spacing = 20
        
        view.addSubview(stackView)
        stackView.anchor(
            top: plusPhotoButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,
            paddingTop: 32, paddingLeft: 32, paddingRight: 32
        )
        
        view.addSubview(alreadyDontHaveAccountButton)
        alreadyDontHaveAccountButton.centerX(inView: view)
        alreadyDontHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
    }
    
    func configureNotificationObservers() {
        emailTextField.addTarget(self, action: #selector(textDidChaging), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChaging), for: .editingChanged)
        fullnameTextField.addTarget(self, action: #selector(textDidChaging), for: .editingChanged)
        usernameTextField.addTarget(self, action: #selector(textDidChaging), for: .editingChanged)
    }
}

// MARK: - Protocol, Delegate

extension RegisterController: FormViewModel {
    func updateForm() {
        signupButton.backgroundColor = viewmodel.buttonBackgroundColor
        signupButton.setTitleColor(viewmodel.buttonTitleColor, for: .normal)
        signupButton.isEnabled = viewmodel.formIsValid
    }
}

extension RegisterController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        guard let selectedImage = info[.editedImage] as? UIImage else { return }
        profileImage = selectedImage
        plusPhotoButton.layer.cornerRadius = plusPhotoButton.frame.width / 2
        plusPhotoButton.layer.masksToBounds = true
        plusPhotoButton.layer.borderColor = UIColor.white.cgColor
        plusPhotoButton.layer.borderWidth = 2
        plusPhotoButton.setImage(selectedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
        self.dismiss(animated: true, completion: nil)
    }
}
