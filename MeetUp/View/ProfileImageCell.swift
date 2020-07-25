//
//  ProfileImageCell.swift
//  MeetUp
//
//  Created by 酒井ゆうき on 2020/07/25.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

class ProfileImageCell : UICollectionViewCell {
    
    //MARK: - Parts
    private let profileImageView : UIImageView = {
        let iv = UIImageView()
//        iv.contentMode = .scaleAspectFill
        iv.image = #imageLiteral(resourceName: "mPlaceholder")
        return iv
    }()
    
    private let nameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Name"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .red
        addSubview(profileImageView)
        profileImageView.fillSuperview()
        
        addSubview(nameLabel)
        nameLabel.anchor(left : leftAnchor,bottom: bottomAnchor,paddingLeft: 8,paddingBottom: 8)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
