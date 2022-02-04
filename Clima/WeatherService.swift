//
//  WeatherService.swift
//  Clima
//
//  Created by Fernando Zafe on 30/01/2022.
//

import Foundation

protocol WeatherService{
    
    func getCurrentWeather(for city: String) async throws -> WeatherData
    func getExtendedWeather(for city: String) async throws -> ExtendedWeatherData
    
}
