//
//  OpenWeatherMapService.swift
//  Clima
//
//  Created by Fernando Zafe on 30/01/2022.
//

import Foundation
import SwiftUI

class OpenWeatherMapService: WeatherService {
    
    private let key = ""
    private let urlStringCurrentWeather = "https://api.openweathermap.org/data/2.5/weather?q=%@&appid=%@&lang=%@&units=%@"
    private let urlStringExtendedWeather = "https://api.openweathermap.org/data/2.5/onecall?lat=%@&lon=%@&exclude=current,minutely,hourly,alerts&appid=%@&units=%@&lang=%@"
    let unit = "metric"
    let language = "es"
    
    func getCurrentWeather(for city: String) async throws -> WeatherData {
        
        let arguments = [
            city,
            key,
            language,
            unit
        ]
        
        let dirtyUrl = String(format: urlStringCurrentWeather, arguments: arguments).addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let url = URL(string: dirtyUrl!)!
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
                  throw URLError.init(.badURL)
              }
                
        let owd = try JSONDecoder().decode(OpenWeatherData.self, from: data)
        
        let city = city
        let date = Date()
        let coordinate = (owd.coord.lon, owd.coord.lat)
        let temperature = owd.main.temp
        let feelsLike = owd.main.feels_like
        let description = owd.weather.first?.description ?? "Sin descripcion"
        let humidity = owd.main.humidity
        let pressure = owd.main.pressure
        let minTemp = owd.main.temp_min
        let maxTemp = owd.main.temp_max
        
        
        
        return WeatherData(
                           coordinate: coordinate,
                           date: date,
                           temperature: temperature,
                           feelsLike: feelsLike,
                           description: description,
                           humidity: humidity,
                           minTemp: minTemp,
                           maxTemp: maxTemp)
        
    }
    
    func getExtendedWeather(for coordinate: (String, String)) async throws -> ExtendedWeatherData {
        
        let lon = coordinate.0
        let lat = coordinate.1
        let arguments = [
            lat,
            lon,
            key,
            unit,
            language
        ]
        
        
        let dirtyUrl = String(format: urlStringExtendedWeather, arguments: arguments).addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let url = URL(string: dirtyUrl!)!
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
                  throw URLError.init(.badURL)
              }
        
        var extendedData: [WeatherData] = []
        
        print("JSON DATA \(data)")
     
        let eowd = try JSONDecoder().decode(ExtendedOpenWeatherData.self, from: data)
        extendedData = eowd.daily.map({ daily in
                return WeatherData(coordinate: (eowd.lon, eowd.lat),
                                   date: Date(timeIntervalSince1970: Double(daily.dt)),
                                   temperature: daily.temp.day,
                                   feelsLike: daily.feels_like.day,
                                   description: daily.weather.first?.description ?? "Sin descripcion",
                                   humidity: Int(daily.humidity),
                                   minTemp: daily.temp.min,
                                   maxTemp: daily.temp.max)
            })
            
            return extendedData
      

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
    struct Coord: Codable {
        let lon: Double
        let lat: Double
    }
    let main: Main
    let coord: Coord
    let weather: [Weather]
    let wind: Wind
    let visibility: Int
    let name: String
    
}

fileprivate struct ExtendedOpenWeatherData: Codable {
    struct Daily: Codable {
        let dt: UInt
        let sunrise: UInt
        let sunset: UInt
        let pressure: UInt
        let humidity: UInt
        let weather: [OpenWeatherData.Weather]
        let temp: Temp
        let feels_like: FeelsLike
    }
    struct Temp: Codable{
        let day: Double
        let min: Double
        let max: Double
    }
    struct FeelsLike: Codable {
        let day: Double
        let night: Double
        let eve: Double
        let morn: Double
    }
    let lat: Double
    let lon: Double
    let daily: [Daily]
    }

