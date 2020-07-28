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
    
    func downloadCurrnetuserFromFirestore(uid : String, comeltion :  @escaping(_ error : Error?) -> Void) {
          
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
    
    func fetchSpecificUser(userId : String, completion :  @escaping(User) -> Void) {
        
        FirebaseReference(reference: .User).document(userId).getDocument { (snapshot, error) in
            
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            
            guard let snapshot = snapshot else {return}
            
            if snapshot.exists {
                let user = User(_dictionary: snapshot.data()! as NSDictionary)
                completion(user)
            }
        }
    }
    
    func fetchMultipleUser(userIds : [String], completion :  @escaping([User]) -> Void) {
        
        var users = [User]()
        
        userIds.forEach { (userId) in
            
            FirebaseReference(reference: .User).document(userId).getDocument { (snapshot, error) in
                
                if error != nil {
                    print(error!.localizedDescription)
                    return
                }
                
                guard let snapshot = snapshot else {return}
                
                if snapshot.exists {
                    
                    let user = User(_dictionary: snapshot.data()! as NSDictionary)
                    users.append(user)
                    
                    if users.count == userIds.count {
                        completion(users)
                    }
                }
            }
        }
        
        
    }
    

    //MARK: - Like
    
      func fetchCurrentUserLiked(completion :  @escaping(_ likedUserIds : [String]) -> Void) {
          FirebaseReference(reference: .Like).whereField(kLIKEDUSEID, isEqualTo: User.currentId()).getDocuments { (snapshot, error) in
              
            var likedIds = [String]()
            guard let snapshot = snapshot else {return}
            
            guard !snapshot.isEmpty else {completion(likedIds) ; return}
            
            snapshot.documents.forEach { (doc) in
                let data = doc.data()
                let likedId = data[kUID] as! String
                
                likedIds.append(likedId)

                if snapshot.documents.count == likedIds.count {
                    completion(likedIds)
                }
            }
          }
      }
      
    
    func checkIfUserLikedMe(userId : String,completion :  @escaping(_ didLike : Bool) -> Void) {
        FirebaseReference(reference: .Like).whereField(kLIKEDUSEID, isEqualTo: User.currentId()).whereField(kUID, isEqualTo: userId).getDocuments { (snapshot, error) in
            
            guard let snapshot = snapshot else {return}
            
            completion(!snapshot.isEmpty)
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
