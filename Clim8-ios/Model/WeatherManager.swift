//
//  WeatherManager.swift
//  Clim8-ios
//
//  Created by bo zhong on 12/20/22.
//

import Foundation

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=923aebe08acfa3b47e4a8bda538cb2bd&units=imperial"
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        print(urlString)
    }
}
