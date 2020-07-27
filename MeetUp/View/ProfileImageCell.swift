//
//  ProfileImageCell.swift
//  MeetUp
//
//  Created by 酒井ゆうき on 2020/07/25.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

class ProfileImageCell : UICollectionViewCell {
    
    static let identifier = "Cell"
    var user : User? {
        didSet {
            configureUI()
        }
    }


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
    
    let gradientlayer = CAGradientLayer()
    
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
    
    //MARK: - UI
    private func configureUI() {
        guard let user = user else {return}
        
        profileImageView.image = user.avatar
        
        setGradientlayer()
    }
    
    func setGradientlayer() {
        
        gradientlayer.removeFromSuperlayer()
        let colorTop = UIColor.clear.cgColor
        let colorBottom = UIColor.black.cgColor
        
        gradientlayer.colors = [colorTop,colorBottom]
        gradientlayer.locations = [0.0, 1.0]
        gradientlayer.cornerRadius = 0.5
        gradientlayer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        
        gradientlayer.frame = self.frame
        profileImageView.layer.insertSublayer(gradientlayer, at: 0)
    }
}
