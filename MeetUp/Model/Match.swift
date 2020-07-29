//
//  Match.swift
//  MeetUp
//
//  Created by 酒井ゆうき on 2020/07/28.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import Foundation

struct Match {
    
    let id : String
    let memberIDs: [String]
    let date : Date
    
    var dictionary : [String : Any] {
        return [kOBJECTId : id,
                kMEMBERIDS : memberIDs,
                kDATE : date]
    }
    
    func savrTofireStore() {
        FirebaseReference(reference: .Match).document(self.id).setData(self.dictionary)
    }
    
}
