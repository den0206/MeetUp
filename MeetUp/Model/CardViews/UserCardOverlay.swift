//
//  UserCardOverlay.swift
//  MeetUp
//
//  Created by 酒井ゆうき on 2020/07/25.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import Foundation
import Shuffle_iOS

class UserCardOverlay : UIView{
    
    init(direction : SwipeDirection) {
        
        super.init(frame: .zero)
        
        switch direction {
        case .left:
            createLeftOverLay()
        case .right :
            createLeftOverLay()
        default:
            break
            
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createLeftOverLay(){
        let leftTextView = SampleOverlayView(withTitle: "Nope", color: .sampleRed, rotation: CGFloat.pi/10)
        addSubview(leftTextView)
        leftTextView.anchor(top : topAnchor,right: rightAnchor,paddingTop: 30,paddingRight: 14)
    }
    private func createRightOverLay(){
        let rightTextView = SampleOverlayView(withTitle: "like", color: .sampleGreen, rotation: -CGFloat.pi/10)
        addSubview(rightTextView)
        rightTextView.anchor(top : topAnchor,right: leftAnchor,paddingTop: 26,paddingLeft: 14)
        
    }
}

private class SampleOverlayView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    init(withTitle title: String, color: UIColor, rotation: CGFloat) {
        super.init(frame: CGRect.zero)
        layer.borderColor = color.cgColor
        layer.borderWidth = 4
        layer.cornerRadius = 4
        transform = CGAffineTransform(rotationAngle: rotation)
        
        addSubview(titleLabel)
        titleLabel.textColor = color
        titleLabel.attributedText = NSAttributedString(string: title,
                                                       attributes: NSAttributedString.Key.overlayAttributes)
        titleLabel.anchor(top: topAnchor,
                          left: leftAnchor,
                          bottom: bottomAnchor,
                          right: rightAnchor,
                          paddingLeft: 8,
                          paddingRight: 3)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
