//
//  Listner.swift
//  MeetUp
//
//  Created by 酒井ゆうき on 2020/07/23.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import Foundation
import Firebase

class FIrebaseListner {
    static let saherd = FIrebaseListner()
    
    private init() {}
    
    //MARK: - User
    
    func downloadCurrnetuserFromFirestore(uid : String) {
          
          FirebaseReference(reference: .User).document(uid).getDocument { (snapshot, error) in
              
              guard let snapshot = snapshot else {return}
              
              if snapshot.exists {
                  
                  let user = User(_dictionary: snapshot.data()! as NSDictionary)
                  user.saveUserLocaly()
              }
          }
      }
//    func downloadCurrnetuserFromFirestore(uid : String) {
//
//        FirebaseReference(reference: .User).document(uid).getDocument { (snapshot, error) in
//
//            guard let snapshot = snapshot else {return}
//
//            if snapshot.exists {
//
//                let user = User(_dictionary: snapshot.data()! as NSDictionary)
//                user.saveUserLocaly()
//            } else {
//                /// first Login
//
//                if let user = UserDefaults.standard.object(forKey: kCURRENTUSER) {
//
//                    User(_dictionary: user as! NSDictionary).saveUserToFireStore()
//                }
//            }
//        }
//    }
}

