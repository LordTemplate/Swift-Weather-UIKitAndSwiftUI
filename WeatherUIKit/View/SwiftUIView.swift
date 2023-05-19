//
//  SwiftUIView.swift
//  WeatherUIKit
//
//  Created by Ivan Alejandro Hernandez Sanchez on 19/05/23.
//

import SwiftUI

struct SwiftUIView: View {
    @StateObject private var locationManager = LocationManager()
    @State var vm = WeatherViewModel(weatherService: WeatherService())
    @State private var city: String = ""
    @State private var weatherData: WeatherData?
    @State private var showAlert = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("City")) {
                    TextField("Enter city", text: $city)
                    
                    HStack {
                    Button("Search") {
                        
                    }
                    .onTapGesture {
                        searchWeather()
                    }
                    Text(" or ")
                    Button("By my location") {
                        
                    }
                    .onTapGesture {
                        city = ""
                        locationManager.requestLocation()
                        searchWeatherByLocation()
                    }
                    
                    Spacer()
                    }
                }
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Error"),
                        message: Text("Try again"),
                        dismissButton: .default(Text("Ok"))
                    )
                }
                
                // Logic to show the weather info
                if let weatherData = weatherData {
                    Section(header: Text("Weather")) {
                        Image(weatherData.weather.first?.icon ?? "")
                        
                        if !weatherData.name.isEmpty {
                            Text("Place: \(weatherData.name)")
                        }
                        Text("Temperature: \(vm.getTemperatureInCorrectFormat(weatherData.main.temp))ºF")
                        Text("Description: \(weatherData.weather.first?.description ?? "")")
                        
                        Text("Feels Like: \(vm.getTemperatureInCorrectFormat(weatherData.main.feels_like))°F")
                            .font(.subheadline)
                        
                        HStack {
                            Text("Min: \(vm.getTemperatureInCorrectFormat(weatherData.main.temp_min))°F")
                                .font(.subheadline)
                            Text("Max: \(vm.getTemperatureInCorrectFormat(weatherData.main.temp_max))°F")
                                .font(.subheadline)
                        }
                    }
                }
                Text("Autor: IAHS")
            }
            .navigationTitle("Weather Search")
        }
        .onAppear {
            locationManager.requestLocation()
            if let value = UserDefaults.standard.string(forKey: "Place") {
                city = value
                searchWeather()
            }
        }
    }
    
    private func searchWeather() {
        if !city.isEmpty {
            vm.fetchWeatherData(forCity: city, lat: 0, lon: 0) { result in
                if let data = result {
                    self.weatherData = data
                    UserDefaults.standard.set(data.name, forKey: "Place")
                } else {
                    showAlert = true
                }
            }
        } else {
            self.weatherData = nil
            showAlert = true
        }
    }
    
     private func searchWeatherByLocation() {
        vm.fetchWeatherData(forCity: String(), lat: locationManager.latitude, lon: locationManager.longitude) { result in
            if let data = result {
                self.weatherData = data
                UserDefaults.standard.set(data.name, forKey: "Place")
            } else {
                self.weatherData = nil
                showAlert = true
            }
        }
    }
}






