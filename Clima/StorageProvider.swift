//
//  StorageProvider.swift
//  Clima
//
//  Created by Fernando Zafe on 07/02/2022.
//

import Foundation

protocol StorageProvider {
    typealias City = String
    
    func saveAll(cities: [City])
    func save(city: City)
    func getAll() -> [City]?

}
