//
//  UserCardContentView.swift
//  MeetUp
//
//  Created by 酒井ゆうき on 2020/07/25.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

class UserCardContentView : UIView {
    
    private let backgroundVIew : UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let imageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private let gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.black.withAlphaComponent(0.01).cgColor,
                           UIColor.black.withAlphaComponent(0.8).cgColor]
        gradient.startPoint = CGPoint(x: 0.5, y: 0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)
        return gradient
    }()
    
    
    init(withImage : UIImage?) {
        super.init(frame: .zero)
        imageView.image = withImage
        configureUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI
    
    private func configureUI() {
        addSubview(backgroundVIew)
        backgroundVIew.fillSuperview()
        backgroundVIew.addSubview(imageView)
        imageView.fillSuperview()
        
        applyShadow(radius: 8, opacity: 0.2, offset: CGSize(width: 0, height: 2))
        
        backgroundVIew.layer.insertSublayer(gradientLayer, above: imageView.layer)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let heightFactor : CGFloat = 0.35
        gradientLayer.frame = CGRect(x: 0, y: (1 - heightFactor) * bounds.height, width: bounds.width, height: heightFactor * bounds.height)
    }
}


