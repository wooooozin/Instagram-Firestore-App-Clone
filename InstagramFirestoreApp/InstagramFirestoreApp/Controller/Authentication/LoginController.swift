//
//  LoginController.swift
//  InstagramFirestoreApp
//
//  Created by 효우 on 2022/09/29.
//

import UIKit

class LoginController: UIViewController {
    
    // MARK: - Properties

    private var viewmodel = LoginViewModel()
    
    private let iconImage: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "Instagram_logo_white"))
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let emailTextField: UITextField = {
        let tf = CustomTextField(placeholer: "Email")
        tf.keyboardType = .emailAddress
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = CustomTextField(placeholer: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setAuthenticationButton(title: "Log in")
        button.setTitleColor(UIColor(white: 1, alpha: 0.67), for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.1)
        button.isEnabled = false
        return button
    }()
    
    private lazy var forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(firstPart: "Forgot you password?", seconPart: "Get help signing in.")
        return button
    }()
    
    private lazy var dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(firstPart: "Don't have an accont?", seconPart: "Sign Up.")
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Life cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNotificationObservers()
    }
    
    // MARK: - Actions
    
    @objc func handleShowSignUp() {
        print("Debug: show sign up herer..")
        let controller = RegisterController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func textDidChaging(sender: UITextField) {
        if sender == emailTextField {
            viewmodel.email = sender.text
        } else {
            viewmodel.password = sender.text
        }
        updateForm()
    }
    
}
    // MARK: - Methods
extension LoginController: FormViewModel {
    func configureUI() {
        configuareGradientLayer()
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        view.addSubview(iconImage)
        iconImage.centerX(inView: view)
        iconImage.setDimensions(height: 80, width: 180)
        iconImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        
        let stackView = UIStackView(arrangedSubviews: [
            emailTextField, passwordTextField, loginButton, forgotPasswordButton
        ])
        stackView.axis = .vertical
        stackView.spacing = 20
        
        view.addSubview(stackView)
        stackView.anchor(
            top: iconImage.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,
            paddingTop: 32, paddingLeft: 32, paddingRight: 32
        )
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.centerX(inView: view)
        dontHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
    }
    
    func configureNotificationObservers() {
        emailTextField.addTarget(self, action: #selector(textDidChaging), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChaging), for: .editingChanged)
    }
    
    func updateForm() {
        loginButton.backgroundColor = viewmodel.buttonBackgroundColor
        loginButton.setTitleColor(viewmodel.buttonTitleColor, for: .normal)
        loginButton.isEnabled = viewmodel.formIsValid
    }
}
