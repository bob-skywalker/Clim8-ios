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
    func didFailWithError(error: Error)
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
                    self.delegate?.didFailWithError(error: error!)
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
            let firstDayWeather = decodedData.list[5].main.temp
            let secondDayWeather = decodedData.list[13].main.temp
            let thirdDayWeather = decodedData.list[21].main.temp
            let forthDayWeather = decodedData.list[29].main.temp
            let conditionID1 = decodedData.list[5].weather[0].id
            let conditionID2 = decodedData.list[13].weather[0].id
            let conditionID3 = decodedData.list[21].weather[0].id
            let conditionID4 = decodedData.list[29].weather[0].id
            let description1 = decodedData.list[5].weather[0].description
            let description2 = decodedData.list[13].weather[0].description
            let description3 = decodedData.list[21].weather[0].description
            let description4 = decodedData.list[29].weather[0].description
            
            let forecast = ForecastModel(description1: description1, description2: description2, description3: description3, description4: description4, firstDayWeather: firstDayWeather, secondDayWeather: secondDayWeather, thirdDayWeather: thirdDayWeather, forthDayWeather: forthDayWeather, conditionID1: conditionID1, conditionID2: conditionID2, conditionID3: conditionID3, conditionID4: conditionID4)
            return forecast
            
        } catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
