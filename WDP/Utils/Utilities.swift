//
//  Utilities.swift
//  WDP
//
//  Created by Thanuja Nayanajith on 4/26/21.
//  Copyright © 2021 NIBM. All rights reserved.
//

import Foundation
import UIKit


class Utilities{
    
    static func filledButton(button:UIButton){
        button.layer.cornerRadius = 25.0
    }
    
    static func calculateCelsius(fahrenheit: Double) -> Double {
        var celsius: Double
        celsius = (fahrenheit - 32) * 5 / 9
        let divisor = pow(10.0, Double(2))
        return (celsius * divisor).rounded() / divisor
    }
}
