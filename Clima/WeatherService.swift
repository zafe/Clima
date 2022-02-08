//
//  WeatherService.swift
//  Clima
//
//  Created by Fernando Zafe on 30/01/2022.
//

import Foundation

protocol WeatherService{
    typealias Latitude = String
    typealias Longitude = String
    
    func getCurrentWeather(for city: String) async throws -> WeatherData
    func getExtendedWeather(for city: (Longitude, Latitude)) async throws -> ExtendedWeatherData
    
}
