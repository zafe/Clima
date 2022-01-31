//
//  ContentView.swift
//  Clima
//
//  Created by Fernando Zafe on 30/01/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State var cityName = "Tucuman"

    
    var body: some View {
        
        Text("Ciudad \(cityName)")
    
        TextField("Introduzca una ciudad", text: $cityName)
        
       
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
