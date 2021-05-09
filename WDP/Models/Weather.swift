//
//  Weather.swift
//  WDP
//
//  Created by Thathsara Senarathne on 2021-05-08.
//  Copyright © 2021 NIBM. All rights reserved.
//

import Foundation

struct Weather: Decodable {
    var temperature: Double!
    var humidity: Double!
    var windSpeed: Double!
}

struct WeatherDataModel: Decodable {
    var message: String!
    var data: Weather!
}
