//
//  ExtendedView.swift
//  Clima
//
//  Created by Fernando Zafe on 07/02/2022.
//

import SwiftUI
import MapKit

struct ExtendedView: View {
    @State private var region: MKCoordinateRegion
    @ObservedObject private var viewModel: MainViewModel
    var city: CityWeatherData
    
    init(city: CityWeatherData, viewModel: MainViewModel){
        self.city = city
        self.viewModel = viewModel
        self.region =  MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: city.currentWeather.coordinate.1, longitude: city.currentWeather.coordinate.0 - 0.1), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0))
    }

        var body: some View {
            VStack{
            ZStack(alignment: .bottomLeading){
            Map(coordinateRegion: $region)
                    .overlay(
                        LinearGradient(gradient: Gradient(colors: [.black.opacity(0.2), .black.opacity(0.7)]), startPoint: .top, endPoint: .bottom)
                        )
                HStack{
                WeatherSummary(cityWeather: city).shadow(color: .white, radius: 5)
                    .padding(.leading, 15)
                    .padding(.bottom, 25)
                    Spacer()
                    Text("Hoy").font(.largeTitle).bold()
                        .shadow(color: .white, radius: 5)
                        .padding()
                }.task {
                    Task{
                        await viewModel.updateExtendedWeather(for: self.city)
                    }
                }
            }
            .frame(height: 200)
                Divider().padding(0)
            Text("Extendido")
            
            if let index = viewModel.data.firstIndex(where: {$0.id == city.id}),
               let cityWeatherData = viewModel.data[index], city.extendedWeather != nil {
            TabView {
                Group{
                    ForEach(cityWeatherData.extendedWeather, id: \.id){ city in
                        VStack{
                            ExtendedDetailView(cityWeatherData: city).padding()
                        }
                                }
                                }
                            }
                            .tabViewStyle(PageTabViewStyle())
                
            }
                else {
                    ProgressView()
                        .task {
                            Task{
                                await viewModel.updateExtendedWeather(for: self.city)
                            }
                        }
                }
            Spacer()
            }.ignoresSafeArea()
            }
}

struct ExtendedView_Previews: PreviewProvider {
    
    static var location = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    static var citty = CityWeatherData(
        city: "Londres",
        currentWeather: WeatherData(coordinate: (-0.1257, 51.5085), date: Date(), temperature: 23.0, feelsLike: 24.5, description: "Nubes de algodón", humidity: 3, minTemp: 12.0, maxTemp: 32.0)
    )
    
    static var previews: some View {
        ExtendedView(city: Self.citty, viewModel: MainViewModel())
    }
}
