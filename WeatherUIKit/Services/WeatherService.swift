//
//  WeatherService.swift
//  WeatherUIKit
//
//  Created by Ivan Alejandro Hernandez Sanchez on 19/05/23.
//

import Foundation

protocol WeatherServiceProtocol {
    func GetWeather(lat: Double, lon: Double, completion: @escaping (Result<WeatherData, Error>) -> Void)
    func GetWeather(city: String, completion: @escaping (Result<WeatherData, Error>) -> Void)
}

/// Class to have the methos to call the services
/// With more time I can have a better class to call services
class WeatherService: WeatherServiceProtocol {

    // TODO: Get shared instance
    
    /// Get the weather by lat/lon
    func GetWeather(lat: Double, lon: Double, completion: @escaping (Result<WeatherData, Error>) -> Void) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(Constants.ApiKey)") else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
    
        let dataTask = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data, let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    print(String(data: data, encoding: .utf8)!)

                    let decoder = JSONDecoder()
                    do {
                        let weatherData = try decoder.decode(WeatherData.self, from: data)
                        print(weatherData)
                        completion(.success(weatherData))
                    } catch {
                        print("Error al decodificar JSON: \(error)")
                        completion(.failure(error))
                    }
                }
            } else {
                print("nothing")
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])))   }
        })
        
        dataTask.resume()
    }
    
    /// Get the weather by city name
    func GetWeather(city: String, completion: @escaping (Result<WeatherData, Error>) -> Void) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(Constants.ApiKey)") else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
    
        let dataTask = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data, let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    print(String(data: data, encoding: .utf8)!)

                    let decoder = JSONDecoder()
                    do {
                        let weatherData = try decoder.decode(WeatherData.self, from: data)
                        print(weatherData)
                        completion(.success(weatherData))
                    } catch {
                        print("Error al decodificar JSON: \(error)")
                        completion(.failure(error))
                    }
                }
            } else {
                print("nothing")
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])))   }
        })
        
        dataTask.resume()
    }
}
