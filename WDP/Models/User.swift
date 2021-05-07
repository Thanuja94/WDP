//
//  User.swift
//  WDP
//
//  Created by Thanuja Nayanajith on 5/1/21.
//  Copyright © 2021 NIBM. All rights reserved.
//

import CoreLocation


struct User {
    
    let firstName: String
    let lastName: String
    let email: String
    let uid: String
    let role: String

    
    
    
    
        init(uid: String, dictionary: [String: Any]) {
        self.uid = uid 
        self.firstName = dictionary["firstname"] as? String ?? ""
        self.lastName = dictionary["lastname"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.role = dictionary["role"] as? String ?? ""
       
       
    }

}
