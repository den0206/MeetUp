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
    
    
    //MARK: - Functions
    
    class func loginUser(withEmal : String, password : String, completion :  @escaping(_ error: Error?, _ isEmailVerfied : Bool) -> Void) {
        Auth.auth().signIn(withEmail: withEmal, password: password) { (result, error) in
            guard error != nil else {completion(error, false)
                return
            }
            
            guard (result?.user.isEmailVerified)! else {
                print("No Verified")
                completion(error, false)
                return
            }
            
            /// exist FB
            completion(nil, true)
        }
    }
    
    class func signUpUser(withEmail : String, password : String, userName: String, city : String, isMale : Bool, daterOfBirth : Date, completion : @escaping(_ error : Error?) -> Void) {
        
        Auth.auth().createUser(withEmail: withEmail, password: password) { (result, error) in
            
            guard error != nil else { completion(error!)
                return}
            
            result?.user.sendEmailVerification(completion: { (error) in
                print("Auth email")
            })
            
            if result?.user != nil {
                guard let uid = result?.user.uid else {return}
                
                let user = User(_uid: uid, _email: withEmail, _username: userName, _city: city, _dateOfBirth: daterOfBirth, _isMale: isMale)
  
                user.saveUserLocaly()
            }
            
        }
    }
    
    func saveUserLocaly() {
        UserDefaults.standard.set(self.userDictionary, forKey: kCURRENTUSER)
        UserDefaults.standard.synchronize()
        
    }
    
    
}
