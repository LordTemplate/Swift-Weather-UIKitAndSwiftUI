//
//  WeatherViewModel.swift
//  WeatherUIKit
//
//  Created by Ivan Alejandro Hernandez Sanchez on 19/05/23.
//

import Foundation

///View model to manage the screen
class WeatherViewModel {
    private let weatherService: WeatherService
    
    init(weatherService: WeatherService) {
        self.weatherService = weatherService
    }
    
    /// Function to have only 2 decimals
    func getTemperatureInCorrectFormat(_ temperature: Double) -> String {
        return String(format: "%.2f", temperature)
    }
    
    /// Function to control the service call
    func fetchWeatherData(forCity city: String, lat: Double, lon: Double, completion: @escaping (WeatherData?) -> Void) {
        if !city.isEmpty {
            weatherService.GetWeather(city: city.replacingOccurrences(of: " ", with: "%20")) { result in
                switch result {
                case .success(let weatherData):
                    completion(weatherData)
                case .failure(let error):
                    print("Error fetching weather data: \(error)")
                    completion(nil)
                }
            }
        } else {
            weatherService.GetWeather(lat: lat, lon: lon) { result in
                switch result {
                case .success(let weatherData):
                    completion(weatherData)
                case .failure(let error):
                    print("Error fetching weather data: \(error)")
                    completion(nil)
                }
            }
        }
    }
}
