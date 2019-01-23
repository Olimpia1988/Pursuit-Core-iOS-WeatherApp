//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Olimpia on 1/21/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

final class FavoriteImageHelper {
    private static let fileName = "WeatherApp.plist"
    private static var favoritesImage = [Favorite]()
    
    static func getWeatherData() {
        //File Manager
        let path = DataPersistenceManager.filePathToDocumentsDirectory(filename: fileName).path
        if FileManager.default.fileExists(atPath: path) {
            if let data = FileManager.default.contents(atPath: path) {
                do {
                    let response = try PropertyListDecoder().decode([Favorite].self, from: data)
                    self.favoritesImage = response
                } catch {
                     print("property list decoding error: \(error)")
                }
            } else {
                 print("data is nil")
            }
           
        } else {
            print("\(fileName) does not exist")
        }
   
    }
    
    static func addPhoto(photo: Favorite) {
        favoritesImage.append(photo)
        savePhoto()
        
    }
    
    static func savePhoto() {
        let path = DataPersistenceManager.filePathToDocumentsDirectory(filename: fileName)
        do {
            let data = try PropertyListEncoder().encode(favoritesImage)
            try data.write(to: path, options: Data.WritingOptions.atomic)
        } catch {
            print("property list encoding error: \(error)")
        }
    }
    
    
    
}
