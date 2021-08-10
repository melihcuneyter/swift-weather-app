//
//  DataViewController.swift
//  WeatherAppFull
//
//  Created by Melih Cüneyter on 5.08.2021.
//

import UIKit

class DataViewController: UIViewController {    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    var index: Int?
    var displayText: String?
    var locationNames = [String]()
    var temperature: Double?
    var weatherDescription: String?
    var minTemp: Double?
    var maxTemp: Double?
    var humidity: Int?
    var pressure: Int?
    var wind: String?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        locationNames = UserDefaults.standard.array(forKey: "newLocation") as? [String] ?? ["Veri Yok"]
        getURLandShow()
        labelStyle()
        view.backgroundColor = .lightGray
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        locationNames = UserDefaults.standard.array(forKey: "newLocation") as? [String] ?? ["Veri Yok"]
        UserDefaults.standard.set(locationNames, forKey: "newLocation")
    }
    
    func labelStyle() {
        locationLabel.layer.cornerRadius = 10
        locationLabel.layer.borderWidth = 1
        tempLabel.layer.cornerRadius = 10
        tempLabel.layer.borderWidth = 1
        descriptionLabel.layer.cornerRadius = 10
        descriptionLabel.layer.borderWidth = 1
        minTempLabel.layer.cornerRadius = 10
        minTempLabel.layer.borderWidth = 1
        maxTempLabel.layer.cornerRadius = 10
        maxTempLabel.layer.borderWidth = 1
        humidityLabel.layer.cornerRadius = 10
        humidityLabel.layer.borderWidth = 1
        pressureLabel.layer.cornerRadius = 10
        pressureLabel.layer.borderWidth = 1
        windLabel.layer.cornerRadius = 10
        windLabel.layer.borderWidth = 1
    }
    
    func getURLandShow () {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(locationNames[index!])&appid=d636e8f13d9a778c0e30117188706fb2&units=metric")
        Webservices().downloadServices(url: url!) { (weathers) in
            if let weathers = weathers {
            print(weathers)
            }
            DispatchQueue.main.async {
                let weatherDetail = weathers!.weather.first
                self.locationLabel.text = weathers!.name.uppercased()
                self.tempLabel.text = "\(String(describing: weathers!.main.temp))°"
                self.descriptionLabel.text = weatherDetail!.weatherDescription.uppercased()
                self.minTempLabel.text = "\(String(describing: weathers!.main.tempMin))°"
                self.maxTempLabel.text = "\(String(describing: weathers!.main.tempMax))°"
                self.pressureLabel.text = "\(String(describing: weathers!.main.pressure)) hPa"
                self.humidityLabel.text = "%\(String(describing: weathers!.main.humidity))"
                self.windLabel.text = "\(String(describing: weathers!.wind.speed)) M/S"

                let icon = weatherDetail?.main.lowercased()
                
                if icon!.contains("clear") {
                    self.imageView.image = UIImage(named: "clear")
                } else if icon!.contains("clouds") {
                    self.imageView.image = UIImage(named: "cloud")
                } else if icon!.contains("rain") {
                    self.imageView.image = UIImage(named: "rain")
                } else if icon!.contains("snow") {
                    self.imageView.image = UIImage(named: "snow")
                }
            }
        }
    }
}
