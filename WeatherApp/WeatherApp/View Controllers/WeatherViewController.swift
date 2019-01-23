//
//  ViewController.swift
//  WeatherApp
//
//  Created by Alex Paul on 1/17/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    private var weatherInstance = [Period]() {
        didSet {
            DispatchQueue.main.async {
                self.myCollectionView.reloadData()
            }
          
        }
    }
    
    @IBOutlet weak var textZipCode: UILabel!
    @IBOutlet weak var zipCodeInput: UITextField!
    @IBOutlet weak var weatherTitle: UILabel!
    public var cityNameData = ""
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        zipCodeInput.delegate = self
        toGetData()
        dump(toGetData())
        ZipCodeHelper.getLocationName(from: zipCodeInput.text ?? "11106") { (error, cityName) in
            if let error = error {
                print(error)
            } else if let cityName = cityName {
                self.weatherTitle.text = "Weather cast for \(cityName)"
                self.cityNameData = cityName
            }
        }
        
         print(DataPersistenceManager.filePathToDocumentsDirectory(filename: "WeatherApp.plist"))
    }
    

    private func toGetData() {
        ClientApiWeather.getWeather(keyword: "11106" ) { (appError, data) in
            if let appError = appError {
                print(appError.errorMessage())
            } else if let data = data {
            let response = data
                self.weatherInstance = response[response.count - 1].periods
          
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WeatherSegue" {
            let detailedVC = segue.destination as! DetailedViewController
            let cell = sender as! UICollectionViewCell
            let indexPaths = self.myCollectionView.indexPath(for: cell)
            detailedVC.currentWeatherData = weatherInstance[indexPaths!.row]
            detailedVC.cityName = cityNameData
        }
  
    }
    
}


extension WeatherViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherInstance.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Weather Cell", for: indexPath) as? CustomCell else { return UICollectionViewCell() }
        let dataToSet = weatherInstance[indexPath.row]
        
        cell.dateLabel.text! = dataToSet.dateFormattedString
        cell.hightWeather.text! = "Max: \(dataToSet.maxTempC)C"
        cell.lowWeather.text! = "Min: \(dataToSet.minTempC)C"
        cell.weatherImage.image = UIImage.init(named: dataToSet.icon)
        return cell
    }
    
    
}
extension WeatherViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: myCollectionView.bounds.width, height: myCollectionView.bounds.height)
    }
    
}

extension WeatherViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let textfield = textField.text else {
            return false
        }
        guard textfield.count == 5 else {
            self.textZipCode.text = "Please enter valid Zip Code"
            return false
        }
        ZipCodeHelper.getLocationName(from: textfield) { (error, cityName) in
            if let error = error {
                print("error: \(error)")
            } else if let cityName = cityName {
                self.cityNameData = cityName
                self.weatherTitle.text = "Weather cast for \(cityName)"
                self.cityNameData = cityName
            }
        }
        guard Int(textfield) != nil else {
            self.textZipCode.text = "Please enter valid Zip Code"
            return false
        }
        toGetData()
        return true
    }
}
