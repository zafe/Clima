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
    fileprivate let storage: StorageProvider
    @Published var data: [CityWeatherData]
    
    init(serviceProvider: WeatherService = OpenWeatherMapService(), storageProvider: StorageProvider = DefaultsProvider()){
        self.service = serviceProvider
        self.storage = storageProvider
        self.data = []
    }
    
    func updateCurrentWeatherData() async {
        
        let weatherWatcher = WeatherWatcher(serviceProvider: service, weatherData: data)
        do{
        var index = 0
        for try await weatherData in weatherWatcher {
            defer{
                DispatchQueue.main.async { [weak self] in
                    self?.objectWillChange.send()
                }
            }
            print(weatherData)
            self.data[index].currentWeather = weatherData
            index += 1
        }
            
        } catch {
            //MARK: - TODO Handle Error
        }
    }
    
    func updateExtendedWeather(for city: CityWeatherData) async {
        do{
            guard let index = self.data.firstIndex(where: { $0.id == city.id }) else { return }
            let lon = String(city.currentWeather.coordinate.0)
            let lat = String(city.currentWeather.coordinate.1)
            let extendedWeather = try await self.service.getExtendedWeather(for: (lon, lat))
            self.data[index].extendedWeather = extendedWeather
            DispatchQueue.main.async { [weak self] in
                self?.objectWillChange.send()
            }
        } catch {
            //MARK: - TODO Handle Error
        }
        
    }
    
    func saveAllCities(){
        let cities = self.data.compactMap({ city in
            return city.city
        })
        self.storage.saveAll(cities: cities)
    }

    func getAllCities(){
        guard let cities = self.storage.getAll() else { return }
        cities.forEach({ city in
            let cityWD = CityWeatherData()
            cityWD.city = city
            self.data.add(cityWD)
        })
    }
    
}
