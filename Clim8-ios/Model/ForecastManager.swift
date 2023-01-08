//
//  ForecastManager.swift
//  Clim8-ios
//
//  Created by bo zhong on 1/7/23.
//

import Foundation
import CoreLocation

protocol ForecastManagerDelegate{
    func didUpdateForecast(_ forecastManager: ForecastManager, forecast: ForecastModel)
    func didFailWithForecastError(error: Error)
}



struct ForecastManager{
    var delegate: ForecastManagerDelegate?
    
    let forecastURL =
    "https://api.openweathermap.org/data/2.5/forecast?&appid=923aebe08acfa3b47e4a8bda538cb2bd&units=imperial"
    
    func fetchForecast(cityName: String){
        let replaced = cityName.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
        let urlString = "\(forecastURL)&q=\(replaced)"
        performRequest(with: urlString)
    }
    
    func fetchForecast(latitude: CLLocationDegrees, longtitude: CLLocationDegrees){
        let urlString = "\(forecastURL)&lat=\(latitude)&lon=\(longtitude)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) {(data: Data?, response: URLResponse? , error: Error?) in
                if error != nil {
                    self.delegate?.didFailWithForecastError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let forecast = self.parseJSON(safeData){
                        self.delegate?.didUpdateForecast(self, forecast: forecast)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ forecastData: Data) -> ForecastModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ForecastData.self, from: forecastData)
            let lowDeviation = Double.random(in: 2...5)
            let highDeviation = Double.random(in: 1...3)
            let firstDayLow = decodedData.list[5].main.temp_min - lowDeviation
            let firstDayHigh = decodedData.list[5].main.temp_max + highDeviation
            let secondDayLow = decodedData.list[13].main.temp_min - lowDeviation
            let secondDayHigh = decodedData.list[13].main.temp_max + highDeviation
            let thirdDayLow = decodedData.list[21].main.temp_min - lowDeviation
            let thirdDayHigh = decodedData.list[21].main.temp_max + highDeviation
            let forthDayLow = decodedData.list[29].main.temp_min - lowDeviation
            let forthDayHigh = decodedData.list[29].main.temp_max + highDeviation
            let conditionID1 = decodedData.list[5].weather[0].id
            let conditionID2 = decodedData.list[13].weather[0].id
            let conditionID3 = decodedData.list[21].weather[0].id
            let conditionID4 = decodedData.list[29].weather[0].id
            let description1 = decodedData.list[5].weather[0].description
            let description2 = decodedData.list[13].weather[0].description
            let description3 = decodedData.list[21].weather[0].description
            let description4 = decodedData.list[29].weather[0].description
            let dt1 = decodedData.list[5].dt_txt
            let dt2 = decodedData.list[13].dt_txt
            let dt3 = decodedData.list[21].dt_txt
            let dt4 = decodedData.list[29].dt_txt
            
            let forecast = ForecastModel(description1: description1, description2: description2, description3: description3, description4: description4, firstDayLow: firstDayLow, firstDayHigh: firstDayHigh, secondDayLow: secondDayLow, secondDayHigh: secondDayHigh, thirdDayLow: thirdDayLow, thirdDayHigh: thirdDayHigh, forthDayLow: forthDayLow, forthDayHigh: forthDayHigh, conditionID1: conditionID1, conditionID2: conditionID2, conditionID3: conditionID3, conditionID4: conditionID4, dt1: dt1, dt2: dt2, dt3: dt3, dt4: dt4)
            return forecast
            
        } catch {
            self.delegate?.didFailWithForecastError(error: error)
            return nil
        }
    }
}
