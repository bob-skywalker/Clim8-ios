//
//  weatherData.swift
//  Clim8-ios
//
//  Created by bo zhong on 12/20/22.
//

import Foundation


struct WeatherData: Codable {
    let coord: Coord
    let name: String
    let main: Main
    let weather: [Weather]
    let visibility: Int
}

struct Coord: Codable{
    let lon: Double
    let lat: Double
}

struct Main: Codable{
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let humidity: Int
}

struct Wind: Codable{
    let speed: Double
}

struct Weather: Codable{
    let id: Int 
    let description: String
}
