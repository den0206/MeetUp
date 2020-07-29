//
//  User.swift
//  MeetUp
//
//  Created by 酒井ゆうき on 2020/07/23.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import Foundation
import Firebase
import UIKit

class User : Equatable {
    
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.uid == rhs.uid
    }
    
    let uid : String
    var email : String
    var userName : String
    var dateOfBirth : Date
    var isMale : Bool
    var avatar : UIImage?
    var profession : String
    var jobTitle : String
    var about : String
    var city :String
    var country : String
    var height : Double
    var lookingFor : String
    var avatarLink : String
    
    var likedIdArray : [String]?
    var imageLinks : [String]?
    let registeredDate = Date()
    var pushId : String?
    
    var userDictionary : NSDictionary {
        return NSDictionary(
            objects: [
                self.uid,
                self.email,
                self.userName,
                self.dateOfBirth,
                self.isMale,
                self.profession,
                self.jobTitle,
                self.about,
                self.city,
                self.country,
                self.height,
                self.lookingFor,
                self.avatarLink,
                
                self.likedIdArray ?? [],
                self.imageLinks ?? [],
                self.registeredDate,
                self.pushId ?? ""
            ],
            
            
            forKeys: [kUID as NSCopying,
                      kEMAIL as NSCopying,
                      kUSERNAME as NSCopying,
                      kDATEOFBIRTH as NSCopying,
                      kISMALE as NSCopying,
                      kPROFISSION as NSCopying,
                      kJOBTITLE as NSCopying,
                      kABOUT as NSCopying,
                      kCITY as NSCopying,
                      kCOUNYRY as NSCopying,
                      kHEIGHT as NSCopying,
                      kLOOKINGFOR as NSCopying,
                      kAVATARLINK as NSCopying,
                      
                      kLIKEIDARRAY as NSCopying,
                      kIMAGELINKS as NSCopying,
                      kREGISTERDDATE as NSCopying,
                      kPUSHID as NSCopying
        ])
    }
    

    
    init(_uid : String, _email : String, _username: String,_city : String,_dateOfBirth : Date, _isMale : Bool, _avatarLink : String = "") {
        
        uid = _uid
        email = _email
        userName = _username
        dateOfBirth = Date()
        isMale = _isMale
        avatarLink = _avatarLink
        profession = ""
        jobTitle = ""
        city = _city
        country = ""
        height = 0.0
        lookingFor = ""
        likedIdArray = []
        imageLinks = []
        about = ""
    }
    
    
    init(_dictionary : NSDictionary) {
        uid = _dictionary[kUID] as? String ?? ""
        email = _dictionary[kEMAIL] as? String ?? ""
        userName = _dictionary[kUSERNAME] as? String ?? ""
        isMale = _dictionary[kISMALE] as? Bool ?? true
        avatarLink = _dictionary[kAVATARLINK] as? String ?? ""
        profession = _dictionary[kPROFISSION] as? String ?? ""
        jobTitle = _dictionary[kJOBTITLE] as? String ?? ""
        city = _dictionary[kCITY] as? String ?? ""
        country = _dictionary[kCOUNYRY] as? String ?? ""
        height = _dictionary[kHEIGHT] as? Double ?? 0.0
        lookingFor = _dictionary[kLOOKINGFOR] as? String ?? ""
        likedIdArray = _dictionary[kLIKEIDARRAY] as? [String]
        imageLinks = _dictionary[kLOOKINGFOR] as? [String]
        about = _dictionary[kABOUT] as? String ?? ""
        pushId = _dictionary[kPUSHID] as? String ?? ""
        
        if let date = _dictionary[kDATEOFBIRTH] as? Timestamp {
            dateOfBirth = date.dateValue()
        } else {
            dateOfBirth = _dictionary[kDATEOFBIRTH] as? Date ?? Date()
        }
        
        let placeHolder = isMale ? "mPlaceholder" : "fPlaceholder"
        avatar =  UIImage(contentsOfFile: fileInDocumentDirectry(filename: self.uid)) ?? UIImage(named: placeHolder)
        
        
    }
    
    
    //MARK: - Helper
    
    class func currentId() -> String {
        return Auth.auth().currentUser!.uid
    }
    
    class func currentUser() -> User? {
        
        if Auth.auth().currentUser != nil {
            if let dictionary = UserDefaults.standard.object(forKey: kCURRENTUSER) {
                return User(_dictionary: dictionary as! NSDictionary)
            }
        }
         return nil
    }
    
    func getUserAvatarFromFiresore(comletion :  @escaping(_ didSet : Bool) -> Void) {
        FileStorage.downloadImage(imageUrl: self.avatarLink) { (avatarImage) in
            
            let placeHolder = self.isMale ? "mPlaceholder" : "fPlaceholder"
            
            self.avatar = avatarImage ?? UIImage(named: placeHolder)
            
            comletion(true)
        }
    }
    
    //MARK: - Functions
    
    class func loginUser(withEmal : String, password : String, completion :  @escaping(_ error: Error?) -> Void) {
        
        Auth.auth().signIn(withEmail: withEmal, password: password) { (result, error) in
            
            if error != nil {
                completion(error)
                return
            }
            
            guard let uid = result?.user.uid else {return}
            print(uid)
            print("Set")
            /// set currentUser
            FIrebaseListner.saherd.downloadCurrnetuserFromFirestore(uid: uid) { (error) in
                completion(error)
            }
            
        
        }
    }
    
  
    
    class func signUpUser(withEmail : String, password : String, userName : String, city : String, isMale : Bool,dateOfBirth : Date, completion : @escaping(_ error : Error?) -> Void) {
        Auth.auth().createUser(withEmail: withEmail, password: password) { (result, error) in
            
            guard error == nil else {completion(error)
                return
            }
            
            if result?.user != nil {
                guard let uid = result?.user.uid else {return}
                let user = User(_uid: uid, _email: withEmail, _username: userName, _city: city, _dateOfBirth: dateOfBirth, _isMale: isMale)
                
                user.saveUserLocaly()
                user.saveUserToFireStore()
            }
        }
    }
    
    class func logOutCurrentUser(comletion :  @escaping(_ error : Error?) -> Void) {
        
        do {
            try Auth.auth().signOut()
            UserDefaults.standard.removeObject(forKey: kCURRENTUSER)
            UserDefaults.standard.synchronize()
        

        } catch let error{
            comletion(error)
        }
    }
    
    //MARK: - email Verification
    
//    class func loginUserWithVerification(withEmal : String, password : String, completion :  @escaping(_ error: Error?, _ isEmailVerfied : Bool) -> Void) {
//          Auth.auth().signIn(withEmail: withEmal, password: password) { (result, error) in
//              guard error != nil else {completion(error, false)
//                  return
//              }
//
//              guard (result?.user.isEmailVerified)! else {
//                  print("No Verified")
//                  completion(error, false)
//                  return
//              }
//
//              guard let uid = result?.user.uid else {return}
//              /// exist FB
//              FIrebaseListner.saherd.downloadCurrnetuserFromFirestore(uid: uid, email: withEmal)
//
//              completion(nil, true)
//          }
//      }
    
//    class func signUpUserWithVerification(withEmail : String, password : String, userName: String, city : String, isMale : Bool, daterOfBirth : Date, completion : @escaping(_ error : Error?) -> Void) {
//
//        Auth.auth().createUser(withEmail: withEmail, password: password) { (result, error) in
//
//            guard error == nil else { completion(error!)
//                return}
//
//            result?.user.sendEmailVerification(completion: { (error) in
//                print("Auth email")
//            })
//
//            if result?.user != nil {
//                guard let uid = result?.user.uid else {return}
//
//                let user = User(_uid: uid, _email: withEmail, _username: userName, _city: city, _dateOfBirth: daterOfBirth, _isMale: isMale)
//
//                user.saveUserLocaly()
//            }
//
//        }
//    }
    
    //MARK: - Edit uer
    
    func updateUserEmail(email : String, completion :  @escaping(_ error : Error?) -> Void) {
        
        Auth.auth().currentUser?.updateEmail(to: email, completion: { (error) in
            if error != nil {
                completion(error)
                return
            }
            
            
            /// resend vertification Email (no use)
//            User.resendVerificationEmail(email: email) { (error) in
//
//                if error != nil {
//                    completion(error)
//                    return
//                }
//            }
        })
    }

    
    //MARK: - ResendLink
    
    class func resendVerificationEmail(email : String, completion : @escaping(_ error : Error?) -> Void) {
        
        Auth.auth().currentUser?.reload(completion: { (error) in
            Auth.auth().currentUser?.sendEmailVerification(completion: { (error) in
                
                completion(error)
            })
        })
    }
    
    class func resetPasword(email : String, completion :  @escaping(_ error : Error?) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            completion(error)
        }
    }
    //MARK: - Save User
    
    func saveUserLocaly() {
        UserDefaults.standard.set(self.userDictionary, forKey: kCURRENTUSER)
        UserDefaults.standard.synchronize()
        
    }
    
    func saveUserToFireStore() {
        
        FirebaseReference(reference: .User).document(self.uid).setData(self.userDictionary as! [String : Any])
    }
    
    //MARK: - Likes
    
    func updateCurrentUserInFireStore(withValue: [String : Any], completion :  @escaping(_ error : Error? ) -> Void) {
        
        guard let dictionary = UserDefaults.standard.object(forKey: kCURRENTUSER) else {return}
        print(dictionary)
//
        let userObject = (dictionary as! NSDictionary).mutableCopy() as! NSMutableDictionary
        userObject.setValuesForKeys(withValue)
      
      
        FirebaseReference(reference: .User).document(User.currentId()).updateData(withValue) { (error) in
            
            if error == nil {
                /// no error
                User(_dictionary: userObject).saveUserLocaly()
            }
        }
        
    }
    
}


func createDummyUsers() {
    let names : [String] = ["1","2","3","4","5", "6"]
    var userIndex = 1
    var imageIndex = 1
    var isMale = true
    
    for i in 0..<5{
        let id = UUID().uuidString
        let fileDirectory = "Avatars/_" + id + ".jpeg"
        
        FileStorage.uploadImage(UIImage(named: "user\(imageIndex)")!, directry: fileDirectory) { (avatarLink) in
            
            let user = User(_uid: id, _email: "user\(imageIndex)@gmail.com", _username: names[userIndex], _city: "Tokyo", _dateOfBirth: Date(), _isMale: isMale,_avatarLink: avatarLink ?? "")
           
            isMale.toggle()
            userIndex += 1
            user.saveUserToFireStore()
        }
        
        imageIndex += 1
        if imageIndex == 16 {
            imageIndex = 1
        }

    }
}
