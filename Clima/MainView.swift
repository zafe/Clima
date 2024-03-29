//
//  ContentView.swift
//  Clima
//
//  Created by Fernando Zafe on 30/01/2022.
//

import SwiftUI

struct MainView: View {
    
    @State var cityName = ""
    @State var selectedCity: CityWeatherData? = nil
    @FocusState private var cityFieldIsFocused: Bool
    @StateObject private var viewModel = MainViewModel()

    var body: some View {
        
        VStack{
            Text("Clima").font(.largeTitle).bold()
            .task {
                Task{
                    viewModel.getAllCities()
                    await viewModel.updateCurrentWeatherData()
                }
            }
    
            HStack(alignment: .center){
                Image(systemName: "magnifyingglass").foregroundColor(.gray).padding(.leading, 5)
                TextField("Introduzca una ciudad", text: $cityName)
                    .focused($cityFieldIsFocused)
                    .onSubmit({
                        guard cityName != "" else {return}
                        addCity()
                    })
                    .padding([.top, .bottom], 5)
                if cityName != "" {
                    Button(action:{
                        cityName = ""
                        cityFieldIsFocused = true
                    }, label: {
                        Image(systemName: "x.circle.fill").foregroundColor(.gray)
                    })
                    .padding(.trailing, 5)
                }
            }
            .background(RoundedRectangle(cornerRadius: 5)
                            .foregroundColor(.gray).opacity(0.2))
            .padding(5)
                

               
        Button(
            action: addCity, label: {
            HStack{
                Image(systemName: "plus.circle")
                Text("Agregar Ciudad")
            }
        }).disabled(cityName == "")
        
            if viewModel.data.count > 0 {
            
           /* ForEach($viewModel.data, id: \.id){ $data in
                if data.currentWeather != nil {
                WeatherSummary(cityWeather: data)
                    Spacer()
                }else{
                    ProgressView("Cargando...")
                }
            }*/
        
        List($viewModel.data){ $data in
            if data.currentWeather != nil {
              
                    WeatherSummary(cityWeather: data)
                    
                    .onTapGesture {
                        self.selectedCity = data
                    }
                        .swipeActions{
                            Button(action: {
                                viewModel.data.removeAll(where: {
                                    $0.id == $data.id
                                })
                                viewModel.saveAllCities()
                            }, label: {
                                Image(systemName: "trash")
                            }).tint(.red)
                    }
                        
            } else {
                HStack(alignment: .center){
                Spacer()
                    HStack{
                        Spacer()
                        Text("cargando ciudad ⏳")
                        Spacer()
                        }.foregroundColor(.gray)
                    }.swipeActions{
                        Button(action: {
                            viewModel.data.removeAll(where: {
                                $0.id == $data.id
                            })
                        }, label: {
                            Image(systemName: "trash")
                        }).tint(.red)
                    }
                }
            }
        .refreshable {
            await viewModel.updateCurrentWeatherData()
        }
        .sheet(item: $selectedCity){ city in
        
            ExtendedView(city: city, viewModel: self.viewModel)
            
        }
        }
            else {
                Spacer()
                Text("Agrega una ciudad para ver el clima").foregroundColor(.gray)
                Spacer()
            }
        }
        }
    
    private func addCity() {
    
        let newCity = CityWeatherData()
            newCity.city = cityName
            viewModel.data.add(newCity)
            Task {
                await viewModel.updateCurrentWeatherData()
                viewModel.saveAllCities()
            }
    }
}
  

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
