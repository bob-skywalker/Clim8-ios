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
    let dt1: String
    let dt2: String
    let dt3: String
    let dt4: String
    
    var dt1ToDay: String {
        let dt1DateArr = dt1.split(separator: " ")
        let dt1Date = dt1DateArr[0]
        
        let dt1Num = getDayOfWeek(String(dt1Date))
        switch dt1Num {
        case 1:
            return "Sun"
        case 2:
            return "Mon"
        case 3:
            return "Tue"
        case 4:
            return "Wed"
        case 5:
            return "Thu"
        case 6:
            return "Fri"
        case 7:
            return "Sat"
        default:
            return "NaN"
        }
    }
    
    var dt2ToDay: String {
        let dt2DateArr = dt2.split(separator: " ")
        let dt2Date = dt2DateArr[0]
        
        let dt2Num = getDayOfWeek(String(dt2Date))
        switch dt2Num {
        case 1:
            return "Sun"
        case 2:
            return "Mon"
        case 3:
            return "Tue"
        case 4:
            return "Wed"
        case 5:
            return "Thu"
        case 6:
            return "Fri"
        case 7:
            return "Sat"
        default:
            return "NaN"
        }
    }
    
    var dt3ToDay: String {
        let dt3DateArr = dt3.split(separator: " ")
        let dt3Date = dt3DateArr[0]
        
        let dt3Num = getDayOfWeek(String(dt3Date))
        switch dt3Num {
        case 1:
            return "Sun"
        case 2:
            return "Mon"
        case 3:
            return "Tue"
        case 4:
            return "Wed"
        case 5:
            return "Thu"
        case 6:
            return "Fri"
        case 7:
            return "Sat"
        default:
            return "NaN"
        }
    }
    
    var dt4ToDay: String {
        let dt4DateArr = dt4.split(separator: " ")
        let dt4Date = dt4DateArr[0]
        
        let dt4Num = getDayOfWeek(String(dt4Date))
        switch dt4Num {
        case 1:
            return "Sun"
        case 2:
            return "Mon"
        case 3:
            return "Tue"
        case 4:
            return "Wed"
        case 5:
            return "Thu"
        case 6:
            return "Fri"
        case 7:
            return "Sat"
        default:
            return "NaN"
        }
    }
    
    
    
    func getDayOfWeek(_ today:String) -> Int? {
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let todayDate = formatter.date(from: today) else { return nil }
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: todayDate)
        return weekDay
    }
    
   
    
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
