//
//  DetailedViewController.swift
//  WeatherApp
//
//  Created by Olimpia on 1/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController {
     var currentPhoto: WeatherModel?
   public var currentWeatherData: Period!
    public var imageIndex: Int?
    @IBOutlet weak var weatherTitle: UILabel!
    @IBOutlet weak var cityImage: UIImageView!
    @IBOutlet weak var weatherDescription: UILabel!
    @IBOutlet weak var high: UILabel!
    @IBOutlet weak var low: UILabel!
    @IBOutlet weak var sunrise: UILabel!
    @IBOutlet weak var sunset: UILabel!
    @IBOutlet weak var windspread: UILabel!
    @IBOutlet weak var inchesOfrain: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherTitle.text = "Weather forecast of \(currentWeatherData.dateFormattedString)"
        weatherDescription.text = currentWeatherData.weather
        high.text = ("High: \(currentWeatherData.maxTempC) *C")
        
//        low.text = ("Low: \(currentWeatherData)! *C")
        sunrise.text = currentWeatherData.sunriseFormattedString
//        sunset.text = currentWeatherData.sunsetTime
        windspread.text = ("Windspeed: \(currentWeatherData.windSpeedKPH) kph")
        inchesOfrain.text = ("Inches of presipitation: \(currentWeatherData.pressureIN) in")
        
    }
    

   
    @IBAction func favoritesAddButton(_ sender: UIBarButtonItem) {
        guard let image = cityImage.image else { return }
        if let imageData = image.jpegData(compressionQuality: 0.5) {
            if let imageIndex = imageIndex, let currentPhoto = currentPhoto {
            
            }
        }
    }
    
}
