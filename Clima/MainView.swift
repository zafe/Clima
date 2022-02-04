//
//  ContentView.swift
//  Clima
//
//  Created by Fernando Zafe on 30/01/2022.
//

import SwiftUI

struct MainView: View {
    
    @State var cityName = "Tucuman"
    private var viewModel = MainViewModel()

    
    var body: some View {
        
        Text("Ciudad \(cityName)")
            .task {
                Task{
                    await viewModel.updateCurrentWeatherData()
                }
            }
    
        TextField("Introduzca una ciudad", text: $cityName)
               
           }
        
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
