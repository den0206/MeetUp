//
//  AboutCell.swift
//  MeetUp
//
//  Created by 酒井ゆうき on 2020/07/23.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

class AboutCell : UITableViewCell {
    
    var user : User? {
        didSet {
            configureUser()
        }
    }
    
    
    //MARK: - Parts

    let titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        label.text = "About Me"
        return label
    }()
    
    let textView : UITextView = {
        let tv = UITextView()
        tv.clipsToBounds = true
        tv.layer.cornerRadius = 10
        return tv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .lightGray
        
        
        addSubview(titleLabel)
        titleLabel.anchor(top : topAnchor,left : leftAnchor, paddingTop: 8,paddingLeft: 8)
        addSubview(textView)
        textView.anchor(top : titleLabel.bottomAnchor,left: leftAnchor,bottom: bottomAnchor,right: rightAnchor,paddingTop: 8,paddingLeft: 16,paddingBottom: 16,paddingRight: 16)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI
    
    private func configureUser() {
        guard let user = user else {return}
        textView.text = user.about
    }
}
