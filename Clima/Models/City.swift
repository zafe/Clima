//
//  City.swift
//  Clima
//
//  Created by Fernando Zafe on 30/01/2022.
//

import Foundation

typealias Longitude = Double
typealias Latitude = Double
typealias Coordinates = (Latitude, Longitude)

        
struct City {
    
    let name: String
    let coordinates: Coordinates?
    
    init(name: String){
        self.name = name
        self.coordinates = nil
    }
    
    init(coordinates: Coordinates){
        self.name = "tucuman"
        self.coordinates = coordinates
    }
            
    
}
