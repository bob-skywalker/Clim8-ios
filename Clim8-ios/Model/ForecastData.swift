//
//  ForecastData.swift
//  Clim8-ios
//
//  Created by bo zhong on 1/7/23.
//

import Foundation

struct ForecastData: Codable {
    let list: [List]
}

struct ForecastCoord: Codable{
    let lon: Double
    let lat: Double 
}


struct List: Codable{
    let dt_txt: String
    let main: Maino
    let weather: [Weathero]
}

struct Maino: Codable{
    let temp: Double
    let temp_min: Double
    let temp_max: Double
}

struct Forecast: Codable{
    let id: Int
    let description: String
}

struct Weathero: Codable{
    let id: Int
    let description: String
}

