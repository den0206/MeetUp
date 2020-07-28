//
//  NotificationCell.swift
//  MeetUp
//
//  Created by 酒井ゆうき on 2020/07/28.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

class NotificationCell : UITableViewCell {
    
    static let identifier = "NotificationCell"
    
    var user : User? {
        didSet {
            loadUser()
        }
    }

    
    //MARK: - Parts
    
    private let profileImageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = .lightGray
        iv.setDimensions(height: 45, width: 45)
        return iv
    }()
    
    private let titleLabel : UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        accessoryType = .disclosureIndicator
        
        addSubview(profileImageView)
        profileImageView.centerY(inView: self)
        profileImageView.anchor(left : leftAnchor, paddingLeft: 16)
        
        addSubview(titleLabel)
        titleLabel.centerY(inView: profileImageView)
        titleLabel.anchor(left : profileImageView.rightAnchor,right: rightAnchor,paddingLeft: 16,paddingRight: 16)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI
    
    private func loadUser() {
        
        guard let user = user else {return}
        profileImageView.image = user.avatar
        titleLabel.text = user.userName
    }
}
