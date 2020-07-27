//
//  GlobalFunctions.swift
//  MeetUp
//
//  Created by 酒井ゆうき on 2020/07/27.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import Foundation

//MARK: - Likes

func saveLike(userId : String) {
       
       let like = LikeObject(id: UUID().uuidString, userID: User.currentId(), likedUserId: userId, date: Date())
       
       guard let currentUser = User.currentUser() else {return}
       
       guard !didLikeUserWith(userId: userId) else {print("already"); return}
    
       currentUser.likedIdArray!.append(userId)
       
       like.savrTofireStore()
       
       currentUser.updateCurrentUserInFireStore(withValue: [kLIKEIDARRAY : currentUser.likedIdArray!]) { (error) in
           
           if error != nil {
               print(error!.localizedDescription)
               return
           }
       }
   }
   

func didLikeUserWith(userId : String) -> Bool {
    return User.currentUser()?.likedIdArray?.contains(userId) ?? false
}
