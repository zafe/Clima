//
//  WeatherData.swift
//  Clima
//
//  Created by Fernando Zafe on 30/01/2022.
//

import Foundation
import CoreImage

struct WeatherData {
    
    let city: City
    let date: Date
    let temperature: Double
    let feelsLike: Double
    let description: String
    let humidity: Int
    let minTemp: Double
    let maxTemp: Double
    
}

typealias ExtendedWeatherData = [WeatherData]
