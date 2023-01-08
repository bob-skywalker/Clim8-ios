//
//  ForecastModel.swift
//  Clim8-ios
//
//  Created by bo zhong on 1/7/23.
//

import Foundation

struct ForecastModel{
    let description1: String
    let description2: String
    let description3: String
    let description4: String
    let firstDayLow: Double
    let firstDayHigh: Double
    let secondDayLow: Double
    let secondDayHigh: Double
    let thirdDayLow: Double
    let thirdDayHigh: Double
    let forthDayLow: Double
    let forthDayHigh: Double
    let conditionID1: Int
    let conditionID2: Int
    let conditionID3: Int
    let conditionID4: Int
    

    
    var conditionName1: String {
        switch conditionID1 {
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
    
    var conditionName2: String {
        switch conditionID2 {
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
    
    var conditionName3: String {
        switch conditionID3 {
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
    
    var conditionName4: String {
        switch conditionID4 {
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
    
}
