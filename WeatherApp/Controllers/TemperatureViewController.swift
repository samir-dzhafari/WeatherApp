//
//  TemperatureViewController.swift
//  WeatherApp
//
//  Created by Самир Джафари on 12.11.2023.
//

import UIKit

class TemperatureViewController: UIViewController {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var city: String!
    var weather: CurrentWeather!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cityLabel.text = city
        temperatureLabel.text = "\(weather.temperature) C"
        descriptionLabel.text = weather.weather_descriptions.joined(separator: ", ")
    }

}
