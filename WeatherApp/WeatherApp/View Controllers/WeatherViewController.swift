//
//  ViewController.swift
//  WeatherApp
//
//  Created by Alex Paul on 1/17/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    private var weatherInstance = [WeatherModel]()
    @IBOutlet weak var zipCodeInput: UITextField!
    @IBOutlet weak var weatherTitle: UILabel!
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    override func viewDidLoad() {
    super.viewDidLoad()
    myCollectionView.dataSource = self

  }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "destinationSegue" {
            guard let destination = segue.destination as? DetailedViewController , let indexPath = myCollectionView.indexPathForItem(at: CGPoint()) else {fatalError("Error in Segeue")}
            destination.currentWeatherData = Weather.getWeatherData()[indexPath.row]
            
        } else if segue.identifier == "destinationSegue" {
            
        }
    }

}


extension WeatherViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherInstance.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Weather Cell", for: indexPath) as? CustomCell else { return UICollectionViewCell() }
        let dataToSet = Weather.getWeatherData()[indexPath.row]
        cell.dateLabel.text! = dataToSet.profile.tz
        return cell
    }
    
    
}
