//
//  Weather.swift
//  WeatherApp
//
//  Created by Olimpia on 1/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation


struct WeatherModel: Codable {
    var periods: [Response]
    var profile: NewYorkCode
    
    struct Response: Codable {
        var moreWeatherInfo: [WeatherInfo]
    }
    
    struct WeatherInfo: Codable {
       var validTime: String
       var dateTimeISO: String
       var maxTempC: Int
       var maxTempF: Int
       var minTempC: Int
       var minTempF: Int
       var avgTempC: Int
       var avgTempF: Int
       var maxHumidity: Int
       var minHumidity: Int
       var humidity: Int
       var uvi: Int
       var pressureIN: Double
       var windSpeedKPH: Int
       var windSpeedMPH: Int
       var weather: String
       var sunrise: Int
       var sunriseISO: String
       var sunset: Int
       var sunsetISO: String
      // var timestamp: Int
    }
    
    struct NewYorkCode: Codable {
        var tz: String
    }
}


// acces ID: PyHW5kIy44vYGeIycdxpB
// secret Key: 002v33INFcQiR3WCE4CJzRQYevU8N3gYvcE9hQ6O

//http://api.aerisapi.com/forecasts/11106?client_id=PyHW5kIy44vYGeIycdxpB&client_secret=002v33INFcQiR3WCE4CJzRQYevU8N3gYvcE9hQ6O
