//
//  OpenWeatherMapService.swift
//  Clima
//
//  Created by Fernando Zafe on 30/01/2022.
//

import Foundation

class OpenWeatherMapService: WeatherService {
    
    private let urlString = "https://api.openweathermap.org/data/2.5/weather?q=%@&appid=&lang=%@&units=%@"
    let unit = "metric"
    let language = "es"
    
    func getCurrentWeather(for city: City) async throws -> WeatherData {
        
        let arguments = [
            city.name,
            language,
            unit
        ]
        
        let dirtyUrl = String(format: urlString, arguments: arguments).addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let url = URL(string: dirtyUrl!)!
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
                  throw URLError.init(.badURL)
              }
                
        let owd = try JSONDecoder().decode(OpenWeatherData.self, from: data)
        
        let city = city
        let date = Date()
        let temperature = owd.main.temp
        let feelsLike = owd.main.feels_like
        let description = owd.weather.first?.description ?? "Sin descripcion"
        let humidity = owd.main.humidity
        let pressure = owd.main.pressure
        let minTemp = owd.main.temp_min
        let maxTemp = owd.main.temp_max
        
        
        
        return WeatherData(city: city,
                           date: date,
                           temperature: temperature,
                           feelsLike: feelsLike,
                           description: description,
                           humidity: humidity,
                           minTemp: minTemp,
                           maxTemp: maxTemp)
        
    }
    
    func getExtendedWeather(for city: City) async throws -> ExtendedWeatherData {
        return ExtendedWeatherData()
    }
}

fileprivate struct OpenWeatherData: Codable {
    
    struct Main: Codable {
        let temp: Double
        let feels_like: Double
        let temp_min: Double
        let temp_max: Double
        let pressure: Int
        let humidity: Int
    }
    struct Weather: Codable{
        let id: Int
        let main: String
        let description: String
    }
    struct Wind: Codable {
        let speed: Double
        let deg: Int
    }
    let main: Main
    let weather: [Weather]
    let wind: Wind
    let visibility: Int
    let name: String
    
}