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
        
        return createContainerView(withLabel: "Email", textField: emaiTextField)

    }()
    
    private lazy var emaiTextField : UITextField = {
        return createtextField(withPlaceholder: "Email", isSecureType: false)
    }()
    
    private lazy var passwordContainerView : UIView = {
        return createContainerView(withLabel: "Password", textField: passwordTextField)
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
    
    private let loginButton : GradientButton = {
        let button = GradientButton(leftColor: #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), rightColor: #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 35 / 2
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        
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
        
    }
    
    //MARK: - Actions
    
    @objc func handleLogin() {
        print("Login")
    }
}
