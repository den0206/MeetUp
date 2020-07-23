//
//  ContentCell.swift
//  MeetUp
//
//  Created by 酒井ゆうき on 2020/07/23.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

protocol ContentCellDelegate : class {
    
    func handlesettingButton()
    func handleCameraButton()
    func handleEditButton()
}

class ContentCell : UITableViewCell {
    
    weak var delegate : ContentCellDelegate?
    
    //MARK: - Parts
    
    private let backView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 100
        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        return view
    }()
    
    private let userImageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = #imageLiteral(resourceName: "avatar")
        iv.setDimensions(height: 150, width: 150)
        iv.layer.cornerRadius = 150 / 2
        iv.clipsToBounds = true
        return iv
    }()
    
    private let userNameLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Name"
        return label
    }()
    
    private let ageLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "ahe"
        return label
    }()
    
    /// buttons
    
    lazy var settingButton : UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(#imageLiteral(resourceName: "settings"), for: .normal)
        button.addTarget(self, action: #selector(tappedSettings), for: .touchUpInside)

        return button
    }()
    
    lazy var cameraButton : UIButton = {
        let button = UIButton(type: .system)
             button.setBackgroundImage(#imageLiteral(resourceName: "camera"), for: .normal)
        button.addTarget(self, action: #selector(tappedCamera), for: .touchUpInside)

        return button
    }()
    
    lazy var editButton : UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(#imageLiteral(resourceName: "edit"), for: .normal)
        button.addTarget(self, action: #selector(tappedEdit), for: .touchUpInside)
        return button
    }()

    //MARK: -
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .lightGray
        
        addSubview(backView)
        backView.fillSuperview()
        
        addSubview(userImageView)
        userImageView.centerX(inView: self)
        userImageView.anchor(top : topAnchor, paddingTop: 60)
        
        addSubview(userNameLabel)
        userNameLabel.centerX(inView: self)
        userNameLabel.anchor(top : userImageView.bottomAnchor, paddingTop: 20)
        
        addSubview(ageLabel)
        ageLabel.centerX(inView: self)
        ageLabel.anchor(top : userNameLabel.bottomAnchor, paddingTop: 5)
        
        let buttonStack = UIStackView(arrangedSubviews: [settingButton,cameraButton,editButton])
        buttonStack.axis = .horizontal
        buttonStack.spacing = 15
        buttonStack.distribution = .fillEqually
        
        addSubview(buttonStack)
        buttonStack.centerX(inView: self)
        buttonStack.anchor(bottom: bottomAnchor, paddingBottom: 20)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    @objc func tappedSettings() {
        delegate?.handlesettingButton()
    }

    @objc func tappedCamera() {
        delegate?.handleCameraButton()
    }
    @objc func tappedEdit() {
        delegate?.handleEditButton()
    }
    
}
