//
//  MainViewModel.swift
//  Clima
//
//  Created by Fernando Zafe on 02/02/2022.
//

import Foundation

class MainViewModel: ObservableObject {
    
    private var service: WeatherService
    @Published var data: [CityWeatherData]!
    
    
    init(serviceProvider: WeatherService = OpenWeatherMapService()){
        self.service = serviceProvider
        var tucuman = CityWeatherData()
        tucuman.city = "san miguel de tucuman"
        var londres = CityWeatherData()
        londres.city = "londres"
        self.data = [tucuman, londres]
    }
    
    func updateCurrentWeatherData() async {
        
        let weatherWatcher = WeatherWatcher(serviceProvider: service, weatherData: data)
        do{
        for try await weatherData in weatherWatcher {
            print(weatherData)
        }
        } catch {
            //MARK: - TODO Handle Error
        }
    }
    
    
}
