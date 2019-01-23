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
    @IBOutlet weak var zipCodeInput: UITextField!
    @IBOutlet weak var weatherTitle: UILabel!
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        print("Data or not data")
        toGetData()
        dump(toGetData())
        
    }
    

    private func toGetData() {
        ClientApiWeather.getWeather(keyword: "11106") { (appError, data) in
            if let appError = appError {
                print(appError.errorMessage())
            } else if let data = data {
            let response = data
                self.weatherInstance = response[response.count - 1].periods
                //dump(self.weatherInstance)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WeatherSegue" {
            let detailedVC = segue.destination as! DetailedViewController
            let cell = sender as! UICollectionViewCell
            let indexPaths = self.myCollectionView.indexPath(for: cell)
            detailedVC.currentWeatherData = weatherInstance[indexPaths!.row]
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
