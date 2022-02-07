//
//  MainViewModel.swift
//  Clima
//
//  Created by Fernando Zafe on 02/02/2022.
//

import Foundation
import SwiftUI
import Combine

@MainActor
class MainViewModel: ObservableObject {
    
    private var service: WeatherService
    @Published var data: [CityWeatherData]
    
    init(serviceProvider: WeatherService = OpenWeatherMapService()){
        self.service = serviceProvider
        var tucuman = CityWeatherData()
        tucuman.city = "san miguel de tucuman"
        self.data = [tucuman]
    }
    
    func updateCurrentWeatherData() async {
        
        let weatherWatcher = WeatherWatcher(serviceProvider: service, weatherData: data)
        do{
        var index = 0
        for try await weatherData in weatherWatcher {
            //self.data[index].city = ["londres","buenos aires","dubai","casablanca"].randomElement()
            print(weatherData)
            self.data[index].currentWeather = weatherData
            
            index += 1
        }
            DispatchQueue.main.async { [weak self] in
                self?.objectWillChange.send()
            }
        } catch {
            //MARK: - TODO Handle Error
        }
    }
    
}
