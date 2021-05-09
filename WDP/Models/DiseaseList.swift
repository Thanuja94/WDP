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
    
    init(diseaseName: String, lowerMargin: Double, higherMargin: Double) {
        self.diseaseName = diseaseName
        self.lowerMargin = lowerMargin
        self.higherMargin = higherMargin
    }
}
