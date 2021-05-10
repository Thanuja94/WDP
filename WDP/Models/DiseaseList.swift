//
//  DiseaseList.swift
//  WDP
//
//  Created by Thanuja Nayanajith on 5/2/21.
//  Copyright © 2021 NIBM. All rights reserved.
//

import Foundation

class DiseaseList {
    
    let diseaseName: String
    let lowerMargin: Double
    let higherMargin: Double
    let ratingValue: Double
    let noOfUsersRate: Double
    
    init(diseaseName: String, lowerMargin: Double, higherMargin: Double, ratingValue: Double, noOfUsersRate: Double) {
        self.diseaseName = diseaseName
        self.lowerMargin = lowerMargin
        self.higherMargin = higherMargin
        self.ratingValue = ratingValue
        self.noOfUsersRate = noOfUsersRate
    }
}
