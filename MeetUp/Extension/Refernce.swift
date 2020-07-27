//
//  Refernce.swift
//  MeetUp
//
//  Created by 酒井ゆうき on 2020/07/23.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import Foundation
import FirebaseFirestore

enum collectionRerence : String {
    case User
    case Like
}

func FirebaseReference(reference : collectionRerence) -> CollectionReference {
    
    return Firestore.firestore().collection(reference.rawValue)    
    
    
}
