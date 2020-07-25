//
//  UserCard.swift
//  MeetUp
//
//  Created by 酒井ゆうき on 2020/07/25.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import Foundation
import Shuffle_iOS

class UserCard : SwipeCard {
    
    func configure(withModel model: UserCardModel) {
        content = UserCardContentView(withImage: model.image)
        footer = UserCardFooterView(title:"\(model.name), \(model.age)", Subtitle: model.occupation)
    }
}
