//
//  Disease.swift
//  WDP
//
//  Created by Thanuja Nayanajith on 5/1/21.
//  Copyright © 2021 NIBM. All rights reserved.
//

import CoreLocation

struct Disease {
    
    let diseaseName: String
    let symptoms: String
    let precautions: String
   

    
    
        init(diseaseName: String, dictionary: [String: Any]) {
        self.diseaseName = dictionary["diseasename"] as? String ?? ""
        self.symptoms = dictionary["symptoms"] as? String ?? ""
        self.precautions = dictionary["precautions"] as? String ?? ""
       
       
       
    }

}
