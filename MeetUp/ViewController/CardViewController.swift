//
//  CardViewController.swift
//  MeetUp
//
//  Created by 酒井ゆうき on 2020/07/25.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit
import Shuffle_iOS
import Firebase
import  ProgressHUD

class CardViewController : UIViewController  {

    //MARK: - Property
    
    private let cardStack = SwipeCardStack()
    private var initialCardModel : [UserCardModel] = []
    private var secoundCardModel : [UserCardModel] = []
    private var userObject = [User]()
    
    var lastDucumentSnapshot : DocumentSnapshot?
    var isInitilaLoad = true
    var showReserve = false
    
    var numberOfCardsAdded = 0
    var initialLoadNumber = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// create Dummy Users(onde time)
//        createDummyUsers()
        

        layoutCardStackView()
        downloadIniaialUsers()
    }
    
    //MARK: - Layout Carsds
    
    private func layoutCardStackView() {
        view.backgroundColor = .white
        cardStack.delegate = self
        cardStack.dataSource = self
        
        view.addSubview(cardStack)
        cardStack.anchor(top : view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor,bottom: view.safeAreaLayoutGuide.bottomAnchor,right: view.safeAreaLayoutGuide.rightAnchor)
    }
    
    //MARK: - API
    private func downloadIniaialUsers() {
        
        ProgressHUD.show()
        
        FIrebaseListner.saherd.downloadUsersFromFirestore(isInitial: isInitilaLoad, limit: initialLoadNumber, lastDocument: nil) { (users, lastDocument) in
            
            guard users.count > 0 else {ProgressHUD.showError("Userが見つかりません"); return}
            
            self.lastDucumentSnapshot = lastDocument
            self.isInitilaLoad = false
            self.userObject = users
            self.initialCardModel = []
            
            users.forEach { (user) in
                user.getUserAvatarFromFiresore { (didset) in
                    
                    let cardModel = UserCardModel(user: user)
                    self.initialCardModel.append(cardModel)
                    self.numberOfCardsAdded += 1
                    
                    if users.count == self.numberOfCardsAdded {
                        /// first reload
                        ProgressHUD.dismiss()
                        
                        DispatchQueue.main.async {
                            self.layoutCardStackView()
                        }
                    }
                    
                }
            }
            
            self.downloadMoreUsers()
            
        }
        
    }
    
    private func downloadMoreUsers() {
//        print(self.lastDucumentSnapshot)
        
        FIrebaseListner.saherd.downloadUsersFromFirestore(isInitial: isInitilaLoad, limit: 10000, lastDocument: lastDucumentSnapshot) { (users, lastDocumrnt) in
            self.lastDucumentSnapshot = lastDocumrnt
            self.secoundCardModel = []
            
            self.userObject += users
            
            users.forEach { (user) in
                user.getUserAvatarFromFiresore { (didSet) in
                    let cardModel = UserCardModel(user: user)
                    self.secoundCardModel.append(cardModel)
        
                }
            }
        }
    }
}

extension CardViewController : SwipeCardStackDelegate, SwipeCardStackDataSource {
    
    func cardStack(_ cardStack: SwipeCardStack, cardForIndexAt index: Int) -> SwipeCard {
        let card = UserCard()
        card.footerHeight = 80
        card.swipeDirections = [.left, .right]
        
        for direction in card.swipeDirections {
            
            card.setOverlay(UserCardOverlay(direction: direction), forDirection: direction)
            
        }
        
        if showReserve {
            card.configure(withModel: secoundCardModel[index])
        } else {
            card.configure(withModel: initialCardModel[index])

        }
        
        return card
    }
    
    func numberOfCards(in cardStack: SwipeCardStack) -> Int {
        
        if showReserve {
            return secoundCardModel.count
        }
        
        return initialCardModel.count
    }
    
    //MARK: - optional Delegate
    
    func cardStack(_ cardStack: SwipeCardStack, didSwipeCardAt index: Int, with direction: SwipeDirection) {
        let user = showReserve ? secoundCardModel[index].user : initialCardModel[index].user
        
        if direction == .right {
            guard !didLikeUserWith(userId: user.uid) else {print("Already"); return}
            
            saveLike(userId: user.uid)
            
            FIrebaseListner.saherd.checkIfUserLikedMe(userId: user.uid) { (didLike) in
                if didLike {
                    print("Match")
                }
            }
            
        } else {
            print(user.userName)
        }
    }
    
    func cardStack(_ cardStack: SwipeCardStack, didSelectCardAt index: Int) {
        
        let user = showReserve ? secoundCardModel[index].user : initialCardModel[index].user

        let profileVC = ProfileViewController(user: user)
//        profileVC.headerCell.delegate = self
        navigationController?.pushViewController(profileVC, animated: true)
    }
    
    func didSwipeAllCards(_ cardStack: SwipeCardStack) {
        initialCardModel = []
        
        if showReserve {
            secoundCardModel = []
        }
        
        showReserve = true
        layoutCardStackView()
    }
    
    
}

extension  CardViewController : ProfileHeaderCellDelegate {
    func tappedDidLikeButton(cell: ProfileHeaderCell) {
        cardStack.swipe(.right, animated: true)
    }
    
    func tappedLikeButton(cell: ProfileHeaderCell) {
        cardStack.swipe(.left, animated: true)

    }
    
    
}
