//
//  City+WeatherData.swift
//  Clima
//
//  Created by Fernando Zafe on 02/02/2022.
//

import Foundation
import SwiftUI

class CityWeatherData: Identifiable, ObservableObject {
     
    fileprivate static let cityLimit = 5
    
    let id = UUID()
    var city: String!//City's name
    var extendedWeather: ExtendedWeatherData!
    @Published var currentWeather: WeatherData!
    
    init(city: String, currentWeather: WeatherData){
        self.city = city
        self.currentWeather = currentWeather
    }
    
    init(){}
    
}

extension Array where Element == CityWeatherData {
    mutating func add(_ newElement: Element){
        if self.count < CityWeatherData.cityLimit { self.append(newElement) }
    }
}
