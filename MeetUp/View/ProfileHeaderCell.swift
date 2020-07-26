//
//  ProfileHeaderCell.swift
//  MeetUp
//
//  Created by 酒井ゆうき on 2020/07/25.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

class ProfileHeaderCell : UITableViewCell {
    
    var user : User?
    
    //MARK: - Parts
    private let backView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 50
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        return view
    }()
    
    private let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
       
        return cv
    }()
    
    private lazy var pageController : UIPageControl = {
        let pg = UIPageControl(frame: .zero)
        pg.currentPage = 0
        
        pg.tintColor = .red
        pg.pageIndicatorTintColor = .black
        pg.currentPageIndicatorTintColor = .green
        return pg
    }()
    
    private lazy var disLikeButton : UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(#imageLiteral(resourceName: "dislike"), for: .normal)
        
        return button
    }()
    
    private lazy var likeButton : UIButton = {
          let button = UIButton(type: .system)
          button.setBackgroundImage(#imageLiteral(resourceName: "like"), for: .normal)

          return button
      }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .lightGray
        
        addSubview(backView)
        backView.fillSuperview()
        
        configureCV()
        configureButtonStack()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI
    private func configureCV() {
        
        backView.addSubview(collectionView)

        collectionView.anchor(top : backView.topAnchor ,left : backView.leftAnchor, right: backView.rightAnchor,paddingTop: 8,paddingLeft: 4,paddingRight: 4,width: 359, height: 459)
        
        collectionView.register(ProfileImageCell.self, forCellWithReuseIdentifier: ProfileImageCell.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        backView.addSubview(pageController)
        pageController.numberOfPages = 4
        pageController.centerX(inView: self)
        pageController.anchor(top : collectionView.bottomAnchor,paddingTop: 8 ,width: 200,height: 20)
        
        
        
    }
    
    private func configureButtonStack() {
        let stack = UIStackView(arrangedSubviews: [disLikeButton,likeButton])
        stack.axis = .horizontal
        
        stack.spacing = 16
        stack.distribution = .fillEqually
        addSubview(stack)
        
        stack.centerX(inView: self)
        stack.anchor(top : pageController.bottomAnchor,paddingTop: 20)
        
       
        
    }
    
}

extension ProfileHeaderCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
//        if ((user?.imageLinks?.count)!) > 0 {
//            return 1 + (user?.imageLinks?.count)!
//        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileImageCell.identifier, for: indexPath) as! ProfileImageCell
        
        cell.user = user
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = frame.width - 15
        let cellHeight = frame.height - 200
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 10
//    }
    
    
}
