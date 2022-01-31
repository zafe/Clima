//
//  WeatherService.swift
//  Clima
//
//  Created by Fernando Zafe on 30/01/2022.
//

import Foundation

protocol WeatherService{
    
    func getCurrentWeather(for city: City) async throws -> WeatherData
    func getExtendedWeather(for city: City) async throws -> ExtendedWeatherData
    
}
