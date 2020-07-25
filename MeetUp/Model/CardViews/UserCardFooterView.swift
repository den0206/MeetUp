//
//  UserCardFooterView.swift
//  MeetUp
//
//  Created by 酒井ゆうき on 2020/07/25.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

class UserCardFooterView : UIView {
    
    private var label = UILabel()
    private var gradientlayer : CAGradientLayer?
    
    init(title : String?, Subtitle : String?) {
        super.init(frame: .zero)
        backgroundColor = .clear
        label.text = title
        layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        layer.cornerRadius = 10
        
        clipsToBounds = true
        isOpaque = false
        
        configureUI(title: title, subTitle: Subtitle)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI
    
    private func configureUI(title : String?, subTitle : String?) {
        let attributedText = NSMutableAttributedString(string: (title ?? "") + "\n",
                                                       attributes: NSAttributedString.Key.titleAttributes)
        if let subtitle = subTitle, !subtitle.isEmpty {
            attributedText.append(NSMutableAttributedString(string: subtitle,
                                                            attributes: NSAttributedString.Key.subtitleAttributes))
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 4
            paragraphStyle.lineBreakMode = .byTruncatingTail
            attributedText.addAttributes([NSAttributedString.Key.paragraphStyle: paragraphStyle],
                                         range: NSRange(location: 0, length: attributedText.length))
            label.numberOfLines = 2
        }
        
        label.attributedText = attributedText
        addSubview(label)
    }
    
    override func layoutSubviews() {
        let padding: CGFloat = 20
        label.frame = CGRect(x: padding,
                             y: bounds.height - label.intrinsicContentSize.height - padding,
                             width: bounds.width - 2 * padding,
                             height: label.intrinsicContentSize.height)
    }
}
