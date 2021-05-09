//
//  CloudRequest.swift
//  WDP
//
//  Created by Thathsara Senarathne on 2021-05-08.
//  Copyright © 2021 NIBM. All rights reserved.
//

import Foundation
import MNkCloudRequest

struct CLoudRequest {
    
    struct EndPoints {
        static var root:String {
            return "https://api.ambeedata.com/"
        }
        
        static var weather: String {
            return root+"weather/latest/by-lat-lng"
        }
    }
    
    static func loadWeatherData(lat: Double, lng: Double, fetched:@escaping (_ weatherData: Weather?, _ err: String?)->()){
        let urlString = EndPoints.weather
        let param = ["lat": lat,
                     "lng": lng]
        let headers = ["x-api-key": "N91kEq23h1kqf5cwWj6l4ohKCCxOlvw5djKkeSwd"]
        
        MNkCloudRequest.request(urlString,
                                .get,
                                param,
                                headers,
                                .none)
        { (cloudResult: WeatherDataModel?, response, err) in
            fetched(cloudResult?.data, err?.localizedDescription)
        }
    }
}
