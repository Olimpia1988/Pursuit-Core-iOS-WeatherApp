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
    var cityName: String!
    var cityNameFormatted: String {
        return cityName.replacingOccurrences(of: " ", with: "+")
    }
    
    public var currentWeatherData: Period!
    public var currentImage: Image!
    public var arrayOfImages = [Image]()
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
        low.text = ("Low: \(String(describing: currentWeatherData))! *C")
        sunrise.text = currentWeatherData.sunriseFormattedString
        sunset.text = "Sunset time: \(currentWeatherData.sunsetTime)"
        windspread.text = ("Windspeed: \(currentWeatherData.windSpeedKPH) kph")
        inchesOfrain.text = ("Inches of presipitation: \(currentWeatherData.pressureIN) in")
        ClientApiWeather.getImage(keyword: "https://pixabay.com/api/?key=11378362-f50c827058ab2657804265f54&q=\(cityNameFormatted)&image_type=photo") { (appError, image) in
            if let appError = appError {
                print(appError.errorMessage())
            } else if let image = image {
              self.arrayOfImages = image
            }
            guard self.arrayOfImages.count > 0 else { return }
            let randomImage = self.arrayOfImages[Int.random(in: 0..<self.arrayOfImages.count - 1)]
            ImageHelper.shared.fetchImage(urlString: randomImage.largeImageURL, completionHandler: { (appError, image) in
                if let appError = appError {
                    print(appError.errorMessage())
                } else if let image = image {
                    self.cityImage.image = image
        }
        
    })
    

   

  }
}
    
    @IBAction func Favorites(_ sender: UIBarButtonItem) {
        let date = Date()
        let isoDateFormatter = ISO8601DateFormatter()
        isoDateFormatter.formatOptions = [.withFullDate,
                                          .withFullTime,
                                          .withInternetDateTime,
                                          .withTimeZone,
                                          .withDashSeparatorInDate]
        
        
        let timeStamp = isoDateFormatter.string(from: date)
        if let imageData = cityImage.image?.jpegData(compressionQuality: 0.5) {
            let photo = Favorite.init(imageData: imageData, createdAt: timeStamp, description: "")
            FavoriteImageHelper.addPhoto(photo: photo)
        }

        let alert = UIAlertController(title: "Saved", message: "Your image has been saved", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default){
            _ in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
}
