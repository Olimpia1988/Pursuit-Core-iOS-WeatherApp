//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Olimpia on 1/21/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

final class Weather {
    private static let fileName = "WeatherApp.plist"
    private static var weather = [WeatherModel]()
    
    static func getWeatherData() -> [WeatherModel] {
        //File Manager
        let path = DataPersistenceManager.filePathToDocumentsDirectory(filename: fileName).path
        if FileManager.default.fileExists(atPath: path) {
            if let data = FileManager.default.contents(atPath: path) {
                do {
                    weather = try PropertyListDecoder().decode([WeatherModel].self, from: data)
                } catch {
                     print("property list decoding error: \(error)")
                }
            } else {
                 print("data is nil")
            }
           
        } else {
            print("\(fileName) does not exist")
        }
       return weather
    }
    
    
}
