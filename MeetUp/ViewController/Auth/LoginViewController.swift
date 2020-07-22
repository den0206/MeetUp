//
//  LoginViewController.swift
//  MeetUp
//
//  Created by 酒井ゆうき on 2020/07/22.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

class LoginViewController : UIViewController {
    
    //MARK: - Parts
    
    private let backgroundImageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = #imageLiteral(resourceName: "loginBavkground")
        return iv
    }()
    
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.text = "Login"
        label.font = UIFont(name: "Avenir-Light", size: 36)
        label.textColor = .white
        return label
    }()
    
    lazy var emailContainerView : UIView = {
        
        return createContainerView("Email", textField: emaiTextField)

    }()
    
    private lazy var emaiTextField : UITextField = {
        return createtextField(withPlaceholder: "Email", isSecureType: false)
    }()
    
    private lazy var passwordContainerView : UIView = {
        return createContainerView("Password", textField: passwordTextField)
    }()
    
    private lazy var passwordTextField : UITextField = {
        return createtextField(withPlaceholder: "Password", isSecureType: true)
    }()
    
    private let forgotButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Forgot Password?", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let loginButton : UIButton = {
        let button = UIButton(type: .system)
//        button.setTitle("Login", for: .normal)
//        button.setTitleColor(.white, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 35 / 2
//        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        
        button.setBackgroundImage(#imageLiteral(resourceName: "signin"), for: .normal)
        
        return button
    }()
    
    let dontHaveAccountButton : UIButton = {
        let button = UIButton(type: .system)
        
        let attributeTitle = NSMutableAttributedString(string: "アカウントを持っていませんか?", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        
        attributeTitle.append(NSMutableAttributedString(string: " Sign Up", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray]))
        
        button.setAttributedTitle(attributeTitle, for: .normal)
        button.addTarget(self, action: #selector(presentSignUp), for: .touchUpInside)
        return button
    }()
    
    
    
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        
    }
    
    //MARK: - UI
    
    private func configureUI() {
        
        view.insertSubview(backgroundImageView, at: 0)
        backgroundImageView.fillSuperview()
        
        view.addSubview(titleLabel)
        titleLabel.centerX(inView: view)
        titleLabel.anchor(top : view.safeAreaLayoutGuide.topAnchor)
        
    
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView,passwordContainerView,forgotButton, loginButton])
        stack.axis = .vertical
        stack.spacing = 50
        stack.distribution = .fillProportionally

        view.addSubview(stack)
        stack.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor,right: view.rightAnchor, paddingTop: 80, paddingLeft: 24,paddingRight: 24)
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.centerX(inView: view)
        dontHaveAccountButton.anchor(bottom : view.safeAreaLayoutGuide.bottomAnchor, paddingBottom:  12)
        
        
    }
    
    //MARK: - Actions
    
    @objc func handleLogin() {
        print("Login")
    }
    
    @objc func presentSignUp() {
        
        let signupVC = SignUpViewController()
        present(signupVC, animated: true, completion: nil)
    }
}