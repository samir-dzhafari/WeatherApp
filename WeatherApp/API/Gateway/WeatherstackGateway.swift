//
//  OpenweatherGateway.swift
//  WeatherApp
//
//  Created by Самир Джафари on 12.11.2023.
//

import Foundation

class WeatherstackGateway {
    static let shared = WeatherstackGateway()
    
    private var baseUrl: String {
        "https://api.weatherstack.com/"
    }
    
    private var apiKey: String {
        "a7f8fedb8af72522fcee36cff9f44554"
    }
    
    private var currentUrl: String {
        "http://api.weatherstack.com/current?access_key=\(apiKey)&query="
    }
    
    private func getCurrentRequest(_ city: String) -> URLRequest {
        let url = URL(string: currentUrl + city)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        return request
    }
    
    private init() {}
    
    func getCurrentTemperature(_ city: String, completion: @escaping (Result<CurrentWeather, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: getCurrentRequest(city)) { data, response, error in
            guard let data = data, error == nil else {
                if let error = error {
                    completion(.failure(error))
                }
                return
            }
            
            do {
                let response = try JSONDecoder().decode(CurrentTemperature.self, from: data)
                completion(.success(response.current))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
