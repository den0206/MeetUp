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
                
                user.getUserAvatarFromFiresore { (didSet) in
                    
                }
                
                
              }
          }
      }
    /// with pagination
    
    func downloadUsersFromFirestore(isInitial : Bool, limit : Int, lastDocument : DocumentSnapshot?, completion :  @escaping(_ users : [User],_ snapshot : DocumentSnapshot?) -> Void) {
        
        var query : Query!
        var users = [User]()
        
        if isInitial {
            query = FirebaseReference(reference: .User).order(by: kREGISTERDDATE, descending: false).limit(to: limit)
        } else {
            
            guard let lastDocument = lastDocument else {return}
            query = FirebaseReference(reference: .User).order(by: kREGISTERDDATE, descending: false).limit(to: limit).start(afterDocument: lastDocument)
            
        }
        
        
        guard query != nil else { completion(users, nil); return}
        
        query.getDocuments { (snapshot, erro) in
            guard let snapshot = snapshot else {return}
            
            if !snapshot.isEmpty {
                
                for doc in snapshot.documents {
                    let userDic = doc.data() as NSDictionary
                    let uid = userDic[kUID] as! String
                    
                    if !((User.currentUser()?.likedIdArray?.contains(uid)) ?? false) && User.currentId() != uid {
                        users.append(User(_dictionary: userDic))
                        
                    }
                }
                
                completion(users, snapshot.documents.last)
                
            } else {
                completion(users, nil)
            }
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
