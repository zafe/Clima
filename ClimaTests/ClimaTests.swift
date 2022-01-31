//
//  ClimaTests.swift
//  ClimaTests
//
//  Created by Fernando Zafe on 30/01/2022.
//

import XCTest
@testable import Clima

class ClimaTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetCurrentWeather_OpenWeatherMap() async {
        
        let openWeatherMapService = OpenWeatherMapService()
        do{
        let weather = try await openWeatherMapService.getCurrentWeather(for: City(name: "san francisco"))
        print("""

        CITY: \(weather.city)
        DATE: \(weather.date)
        TEMPERATURE: \(weather.temperature)
        VISIBILITY: \(weather.description)

        """)
        }catch{
            print("hubo un error")
        }
        
    }


    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
