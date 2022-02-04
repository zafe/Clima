//
//  WeatherWatcher.swift
//  Clima
//
//  Created by Fernando Zafe on 03/02/2022.
//

import Foundation

struct WeatherWatcher: AsyncSequence, AsyncIteratorProtocol{
    
    typealias Element = WeatherData
    private let service: WeatherService
    private var data: [CityWeatherData]
    private var index = 0
    
    init(serviceProvider: WeatherService, weatherData: [CityWeatherData]){
        self.service = serviceProvider
        self.data = weatherData
    }
    
    mutating func next() async throws -> Element? {
        defer{ index += 1 }
        guard index < data.count else { index=0;return nil }
        return try await self.service.getCurrentWeather(for: data[index].city)
    }
    
    func makeAsyncIterator() -> WeatherWatcher {
           self
       }
    
}
