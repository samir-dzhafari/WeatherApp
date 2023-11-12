//
//  CityListViewController.swift
//  WeatherApp
//
//  Created by Самир Джафари on 12.11.2023.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var loadingStackView: UIStackView!
    @IBOutlet weak var searchTF: UITextField!
    
    private let searchController = UISearchController()
    private var currentWeather: CurrentWeather? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingStackView.isHidden = true
    }
    
    @IBAction func searchButtonTapped() {
        loadingStackView.isHidden = false
        
        WeatherstackGateway.shared.getCurrentTemperature(searchTF.text ?? "") { result in
            switch result {
            case .success(let weather):
                DispatchQueue.main.async {
                    self.loadingStackView.isHidden = true
                    self.showTemperatureVC(weather: weather)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.loadingStackView.isHidden = true
                    self.showAlert(errorText: "Error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "temperatureView" else {
            return
        }
        
        guard let temperatureVC = segue.destination as? TemperatureViewController else {
            return
        }
        
        guard let weather = sender as? CurrentWeather else {
            return
        }
        
        temperatureVC.city = searchTF.text
        temperatureVC.weather = weather
    }
}

//MARK: - Private methods
extension SearchViewController {
    private func showTemperatureVC(weather: CurrentWeather) {
        self.performSegue(withIdentifier: "temperatureView", sender: weather)
    }
    
    private func showAlert(errorText: String) {
        let alertVC = UIAlertController(title: "Error", message: errorText, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .cancel)
        alertVC.addAction(ok)
        
        present(alertVC, animated: true)
    }
}
