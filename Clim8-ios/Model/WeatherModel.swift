//
//  WeatherModel.swift
//  Clim8-ios
//
//  Created by bo zhong on 12/20/22.
//

import Foundation

struct WeatherModel{
    let conditionId: Int
    let cityName: String
    let temperature: Double
    let description: String
    
    var temperatureString: String{
        return String(format: "%.1f", temperature)
    }
    
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701:
            return "humidifier.and.droplets"
        case 711:
            return "smoke.fill"
        case 721:
            return "sun.haze"
        case 731:
            return "sun.dust.fill"
        case 741:
            return "cloud.fog.fill"
        case 751:
            return "sun.dust.fill"
        case 761:
            return "sun.dust.fill"
        case 762:
            return "sun.dust.fill"
        case 771:
            return "cloud.snow.fill"
        case 781:
            return "tornado"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud"
        default:
            return "cloud"
        }
    }
    
    var backgroundImage: String{
        switch conditionId {
        case 200...531:
            return "rainy"
        case 600...622:
            return "snowy"
        case 701:
            return "rainy"
        case 711:
            return "cloudy"
        case 731...762:
            return "sunny"
        case 771:
            return "snowy"
        case 781:
            return "windy"
        case 800...804:
            return "sunny"
        default:
            return "sunny"
        }
    }
    
}

