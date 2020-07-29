//
//  MarchViewController.swift
//  MeetUp
//
//  Created by 酒井ゆうき on 2020/07/28.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

class MatchViewController : UIViewController {
    
    var user : User?
    
    //MARK: - Parts
    
    private let contentView : UIView = {
        let view = UIView()
//        view.backgroundColor = .lightGray
        view.backgroundColor = .clear
        view.applyShadow(radius: 8, opacity: 0.2, offset: CGSize(width: 0, height: 2))
        return view
    }()
    
    private let backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 10
        iv.image = #imageLiteral(resourceName: "matchBackground")
        return iv
    }()
    
    private let matchImage : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "matchImage")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private let avatarImageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = #imageLiteral(resourceName: "avatar")
        return iv
        
    }()
    
    private let nameLabel : UILabel = {
        let label = UILabel()
        label.text = "Name / age"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    private let countryLabel : UILabel = {
        let label = UILabel()
        label.text = "Country"
        label.textAlignment = .center
        
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    //MARK: - buttons
    
    private let sendMessageButton : UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(#imageLiteral(resourceName: "sendMessage"), for: .normal)
        return button
    }()
    
    private let keepSwipeButton : UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(#imageLiteral(resourceName: "keepSwiping"), for: .normal)
        return button
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        loadUserDate()
    }
    
    //MARK: - UI
    
    private func configureUI() {
        view.backgroundColor = .white
        view.addSubview(contentView)
        contentView.anchor(top : view.topAnchor,left: view.leftAnchor,right: view.rightAnchor,paddingTop: 40,paddingLeft: 8,paddingRight: 8,height: 500)
        
        contentView.insertSubview(backgroundImageView, at: 0)
        
        backgroundImageView.anchor(top : contentView.topAnchor,left: contentView.leftAnchor, right: contentView.rightAnchor,height: 281)
        
        contentView.addSubview(matchImage)
        matchImage.center(inView: contentView)
        
        
        contentView.addSubview(avatarImageView)
        avatarImageView.centerX(inView: contentView)
        avatarImageView.anchor(bottom : matchImage.topAnchor, paddingBottom: 15)
        
        contentView.addSubview(nameLabel)
        nameLabel.centerX(inView: contentView)
        nameLabel.anchor(top : matchImage.bottomAnchor,left: contentView.leftAnchor, right: contentView.rightAnchor,paddingTop: 8,paddingLeft: 16,paddingRight: 16)
        
        contentView.addSubview(countryLabel)
        countryLabel.centerX(inView: contentView)
        countryLabel.anchor(top : nameLabel.bottomAnchor,left: contentView.leftAnchor, right: contentView.rightAnchor,paddingTop: 8,paddingLeft: 16,paddingRight: 16)
        
        let buttonStack = UIStackView(arrangedSubviews: [sendMessageButton,keepSwipeButton])
        buttonStack.axis = .vertical
        buttonStack.spacing = 16
        buttonStack.distribution = .fillEqually
        
        contentView.addSubview(buttonStack)
        buttonStack.anchor(top : countryLabel.bottomAnchor,left : contentView.leftAnchor,bottom: contentView.bottomAnchor,right: contentView.rightAnchor,paddingTop: 24,paddingLeft: 16,paddingBottom: 24,paddingRight: 8)
    }
    
    private func  loadUserDate() {
        avatarImageView.image = user?.avatar
        
        
    }

    
}
