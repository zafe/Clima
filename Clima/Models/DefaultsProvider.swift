//
//  DefaultsProvider.swift
//  Clima
//
//  Created by Fernando Zafe on 07/02/2022.
//

import Foundation

class DefaultsProvider: StorageProvider {
    
    func saveAll(cities: [String]) {
            UserDefaults.standard.set(cities, forKey: "cities")
    }
    
    func save(city: String) {
        guard var cities = self.getAll() else { return }
        cities.append(city)
        UserDefaults.standard.set(cities, forKey: "cities")
    }
    
    func getAll() -> [String]? {
        return UserDefaults.standard.object(forKey: "cities") as? [String]
    }
}
