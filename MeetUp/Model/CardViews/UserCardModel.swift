//
//  UserCardModel.swift
//  MeetUp
//
//  Created by 酒井ゆうき on 2020/07/25.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

struct UserCardModel {
    
    let user : User
    
    var id : String {return user.uid}
    var name : String {return user.userName}
    var age : Int {return abs(user.dateOfBirth.interVal(ofComponent: .year, fromDate: Date()))}
    var occupation : String? {return user.profession}
    var image : UIImage? {return user.avatar}
    
    init(user : User) {
        self.user = user
    }
    
}
