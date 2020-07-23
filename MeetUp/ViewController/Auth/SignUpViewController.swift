//
//  SIgnUpViewController.swift
//  MeetUp
//
//  Created by 酒井ゆうき on 2020/07/23.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit
import ProgressHUD

class SignUpViewController : UIViewController {
    
    var isMale = true
    
    //MARK: - Parts
    
    private let dismissButton : UIButton = {
        let button = UIButton(type: .system)
        button.setDimensions(height: 30, width: 30)
        button.setImage(#imageLiteral(resourceName: "back").withRenderingMode(.alwaysTemplate), for: .normal)
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    private let backgroundImageView : UIImageView = {
        let iv = UIImageView()
        iv.isUserInteractionEnabled = true
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
    
    private lazy var userNameField : UITextField = {
        return createtextField(withPlaceholder: "Username", isSecureType: false, addBorder: true)
    }()
    
    private lazy var emailField : UITextField = {
        return createtextField(withPlaceholder: "email", isSecureType: false, addBorder: true)
    }()
    
    private lazy var cityField : UITextField = {
        return createtextField(withPlaceholder: "CIty", isSecureType: false, addBorder: true)
    }()
    
    private let sexSegmentControll : UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Male", "Femail"])
        sc.tintColor = UIColor(white: 1, alpha: 0.87)
        sc.addTarget(self, action: #selector(segmentChange(_ :)), for: .valueChanged)
        sc.selectedSegmentIndex = 0
        return sc
    }()
    
    private lazy var birthField : UITextField = {
        return createtextField(withPlaceholder: "Date of Birth", isSecureType: false, addBorder: true)
    }()
    
    private lazy var passwordField : UITextField = {
        return createtextField(withPlaceholder: "passowrd", isSecureType: true, addBorder: true)
    }()
    
    private lazy var passwordConfirmationField : UITextField = {
        return createtextField(withPlaceholder: "passowrdConfirmation", isSecureType: true, addBorder: true)
    }()
    
    private let SignUpButton : UIButton = {
        let button = UIButton(type: .system)
        button.clipsToBounds = true
        button.layer.cornerRadius = 35 / 2
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        
        button.setBackgroundImage(#imageLiteral(resourceName: "Button_sign in"), for: .normal)
        
        return button
    }()
    
    let alreadyHaveAccountButton : UIButton = {
        let button = UIButton(type: .system)
        
        let attributeTitle = NSMutableAttributedString(string: "アカウントを持っている方は?", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        
        attributeTitle.append(NSMutableAttributedString(string: " Log in", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray]))
        
        button.setAttributedTitle(attributeTitle, for: .normal)
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - UI
    
    private func configureUI() {
        
        view.insertSubview(backgroundImageView, at: 0)
        backgroundImageView.fillSuperview()
        
        view.addSubview(dismissButton)
        dismissButton.anchor(top : view.topAnchor,left: view.leftAnchor,paddingTop: 8,paddingLeft: 8)
        
        view.addSubview(titleLabel)
        titleLabel.centerX(inView: view)
        titleLabel.anchor(top : view.safeAreaLayoutGuide.topAnchor)
        
        
        let stack = UIStackView(arrangedSubviews: [userNameField,emailField,cityField,sexSegmentControll, birthField,passwordField,passwordConfirmationField, SignUpButton])
        
        stack.axis = .vertical
        stack.spacing = 40
        stack.distribution = .fillProportionally

        view.addSubview(stack)
        stack.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor,right: view.rightAnchor, paddingTop: 60, paddingLeft: 24,paddingRight: 24)
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.centerX(inView: view)
        alreadyHaveAccountButton.anchor(bottom : view.safeAreaLayoutGuide.bottomAnchor, paddingBottom:  12)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBord))
        backgroundImageView.addGestureRecognizer(tap)
        
        
        
    }
    
    //MARK: - Actions
    
    @objc func handleSignUp() {
        
     
        
        guard isTextDataIsFilled() else {
            ProgressHUD.showError("項目を埋めてください")
            return
        }
        
        guard passwordField.text == passwordConfirmationField.text else {
            ProgressHUD.showError("パスワードが一致しません")
            return
        }
        
        ProgressHUD.show()
        
        /// sign up
        
        User.signUpUser(withEmail: emailField.text!, password: passwordField.text!, userName: userNameField.text!, city: cityField.text!, isMale: isMale, daterOfBirth: Date()) { (error) in
            
            
            guard error != nil else {ProgressHUD.showError(error!.localizedDescription)
                return}
            
            ProgressHUD.showSucceed("email has Sented")
            
            self.dismiss(animated: true, completion: nil)
            
            
            
        }
        
        
    }
    
    @objc func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func dismissKeyBord() {
        view.endEditing(false)
        
    }
    
    @objc func segmentChange(_ sender : UISegmentedControl) {
        isMale = sender.selectedSegmentIndex == 0 ? true : false
        print(isMale)
    }
    
    private func isTextDataIsFilled() -> Bool {
        return userNameField.text != "" && emailField.text != "" && cityField.text != "" && birthField.text != "" && passwordField.text != "" && passwordConfirmationField.text != ""
    }
    
}
