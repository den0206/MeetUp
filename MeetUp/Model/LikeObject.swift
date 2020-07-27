//
//  LikeObject.swift
//  MeetUp
//
//  Created by 酒井ゆうき on 2020/07/27.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import Foundation

struct LikeObject {
    let id : String
    let userID: String
    let likedUserId : String
    let date : Date
    
    var dictionary : [String : Any] {
        return [kOBJECTId : id,
                kUID : userID,
                kLIKEDUSEID : likedUserId,
                kDATE : date]
    }
    
    func savrTofireStore() {
        FirebaseReference(reference: .Like).document(self.id).setData(self.dictionary)
    }
}
