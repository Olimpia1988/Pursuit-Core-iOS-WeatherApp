//
//  Weather.swift
//  WeatherApp
//
//  Created by Olimpia on 1/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation


struct WeatherModel: Codable {
    let response: [Response]
}
    
    struct Response: Codable {
        var loc: Location?
        var intervar: String?
        let periods: [Period]
      
    }
    
    struct Location: Codable {
        var long: Double
        var lat: Double
    }
    
    
    struct Period: Codable {
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
        var icon: String
        var iconImage: String {
            var arrOfImages = [String]()
            arrOfImages.append(contentsOf: icon.components(separatedBy: "."))
            return arrOfImages[0]
        }
       var sunrise: Int
       var sunriseISO: String
        public var dateFormattedString: String {
            let isoDateFormatter = ISO8601DateFormatter()
            var formattedDate = dateTimeISO
            if let date = isoDateFormatter.date(from:dateTimeISO) {
            let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MMM d, yyyy"
                formattedDate = dateFormatter.string(from: date)
            }
            return formattedDate
        }
        public var date: Date {
            let isoFormatter = ISO8601DateFormatter()
            var formattedDate = Date()
            if let date = isoFormatter.date(from: dateTimeISO) {
                formattedDate = date
            }
            return formattedDate
        }
        public var sunriseFormattedString: String {
            let isoDateFormatter = ISO8601DateFormatter()
            var formattedDate = sunsetISO
            if let date = isoDateFormatter.date(from: formattedDate) {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "HH:mm a"
                formattedDate = dateFormatter.string(from: date)
            }
            return formattedDate
        }
        public var sunsetTime: Date {
            let isoFormatter = ISO8601DateFormatter()
            var formattedDate = Date()
            if let date = isoFormatter.date(from: sunsetISO) {
                formattedDate = date
            }
            return formattedDate
        }
       var sunset: Int
       var sunsetISO: String
    
    }



// acces ID: PyHW5kIy44vYGeIycdxpB
// secret Key: 002v33INFcQiR3WCE4CJzRQYevU8N3gYvcE9hQ6O
//http://api.aerisapi.com/forecasts/11106?client_id=PyHW5kIy44vYGeIycdxpB&client_secret=002v33INFcQiR3WCE4CJzRQYevU8N3gYvcE9hQ6O
