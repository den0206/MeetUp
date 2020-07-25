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

class CardViewController : UIViewController  {

    //MARK: - Property
    
    private let cardStack = SwipeCardStack()
    private var initialCardModel : [UserCardModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = User.currentUser()!
        let cardModel = UserCardModel(id: user.uid, name: user.userName, age: abs(user.dateOfBirth.interVal(ofComponent: .year, fromDate: Date())), occupation: user.profession, image: user.avatar)
        
        initialCardModel.append(cardModel)
        
        layoutCardStackView()
        
    }
    
    //MARK: - Layout Carsds
    
    private func layoutCardStackView() {
        cardStack.delegate = self
        cardStack.dataSource = self
        
        view.addSubview(cardStack)
        cardStack.anchor(top : view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor,bottom: view.safeAreaLayoutGuide.bottomAnchor,right: view.safeAreaLayoutGuide.rightAnchor)
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
        card.configure(withModel: initialCardModel[index])
        
        return card
    }
    
    func numberOfCards(in cardStack: SwipeCardStack) -> Int {
        return initialCardModel.count
    }
    
    
}
