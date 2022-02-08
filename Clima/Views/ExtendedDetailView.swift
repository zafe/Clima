//
//  ExtendedDetailView.swift
//  Clima
//
//  Created by Fernando Zafe on 07/02/2022.
//

import SwiftUI

struct ExtendedDetailView: View {
    
    let cityWeatherData: WeatherData
    
    var body: some View {
        VStack(alignment: .leading){
            Text("\(cityWeatherData.date.formatted(date: .abbreviated, time: .omitted))").bold()
            Text("\(cityWeatherData.description)").padding(.bottom)
            HStack{
                Image(systemName: "thermometer")
                Text("\(String(format: "%.1f", cityWeatherData.temperature)) ºC").fontWeight(.black)
                Spacer()
                HStack{
                Image(systemName: "arrow.up.arrow.down.circle")
                VStack(alignment: .leading){
                Text("max \(String(format:"%.1f", cityWeatherData.maxTemp)) ºC").fontWeight(.ultraLight)
                Text("min \(String(format:"%.1f", cityWeatherData.minTemp)) ºC").fontWeight(.ultraLight)
                }.font(.system(size: 20))
                }
            }
            HStack{
                Image(systemName: "thermometer.sun")
                Text("\(String(format: "%.1f", cityWeatherData.feelsLike))").fontWeight(.light)
                
            }.padding(.bottom)
            HStack{
                Image(systemName: "humidity")
                Text("Humedad \(cityWeatherData.humidity)%").fontWeight(.light)
            }
        }.padding()
            .background(LinearGradient(colors: [.blue.opacity(0.8), .cyan], startPoint: .bottom, endPoint: .top))
            .font(.title).foregroundColor(.white)
            .shadow(radius: 3)
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

struct ExtendedDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ExtendedDetailView(cityWeatherData:
            WeatherData(coordinate: (323.23, 2323.3), date: Date(), temperature: 12.3, feelsLike: 23.3, description: "Nubes de almidon", humidity: 3, minTemp: 12.1, maxTemp: 23.2)
        )
.previewInterfaceOrientation(.portrait)
    }
}
