//
//  SearchResponseModel.swift
//  WeatherApp
//
//  Created by Самир Джафари on 12.11.2023.
//

import Foundation

struct CurrentTemperature: Codable {
    let current: CurrentWeather
}

struct CurrentWeather: Codable {
    let temperature: Double
    let weather_descriptions: [String]
}
