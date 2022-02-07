//
//  WeatherSummary.swift
//  Clima
//
//  Created by Fernando Zafe on 04/02/2022.
//

import SwiftUI

struct WeatherSummary: View {
    var cityWeather: CityWeatherData
    
    var body: some View {
      
        VStack(alignment: .leading){
            HStack{
            Text("📍")
                Text(cityWeather.city.capitalized).font(.title)
            }
            
            HStack{
                Image(systemName: "cloud.sun.bolt")
                Text(cityWeather.currentWeather.description.capitalized).font(.body).foregroundColor(.gray).padding(.bottom, 0.9)
            }
            HStack{
                Image(systemName: "thermometer")
                Text("\(String(format: "%.1f", cityWeather.currentWeather.temperature)) ºC").bold()
                Text("\(String(format: "%.1f", cityWeather.currentWeather.feelsLike)) ºC").foregroundColor(.gray)
            }.padding(.bottom, 0.5)
            HStack{
                Image(systemName: "humidity")
                Text("\(cityWeather.currentWeather.humidity)%")
            }
        }
        .cornerRadius(10)
       
    }
}

struct WeatherSummary_Previews: PreviewProvider {
    
    static var citty = CityWeatherData(
        city: "Londres",
        currentWeather: WeatherData(coordinate: (-0.1257, 51.5085), date: Date(), temperature: 23.0, feelsLike: 24.5, description: "Nubes de algodón", humidity: 3, minTemp: 12.0, maxTemp: 32.0)
    )
  
    static var previews: some View {
        
        WeatherSummary(cityWeather: Self.citty)
            .previewLayout(.sizeThatFits)
    }
}
