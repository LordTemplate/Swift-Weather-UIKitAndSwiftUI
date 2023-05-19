//
//  WeatherData.swift
//  WeatherUIKit
//
//  Created by Ivan Alejandro Hernandez Sanchez on 19/05/23.
//

import Foundation

/// Object to know the response for the weather service
struct WeatherData: Codable {
    struct Coordinate: Codable {
        let lon: Double
        let lat: Double
    }
    
    struct Weather: Codable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }
    
    struct Main: Codable {
        let temp: Double
        let feels_like: Double
        let temp_min: Double
        let temp_max: Double
        let pressure: Int
        let humidity: Int
    }
    
    struct Wind: Codable {
        let speed: Double
        let deg: Int?
    }
    
    struct Clouds: Codable {
        let all: Int?
    }
    
    struct System: Codable {
        let type: Int?
        let id: Int?
        let country: String?
        let sunrise: Int?
        let sunset: Int?
    }
    
    let coord: Coordinate
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: Clouds?
    let dt: Int
    let sys: System?
    let timezone: Int
    let id: Int
    let name: String
    let cod: Int
}
