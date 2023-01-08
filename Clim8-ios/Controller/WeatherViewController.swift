//
//  ViewController.swift
//  Clim8-ios
//
//  Created by bo zhong on 12/19/22.
//




import UIKit
import CoreLocation


extension UIImageView {
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                        self?.image = loadedImage
                }
            }
        }
    }
}

class WeatherViewController: UIViewController{
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var weatherCondition: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    
    @IBOutlet weak var forecastView: UIView!
    
    
    
    @IBOutlet weak var currConditionImageView: UIImageView!
    @IBOutlet weak var currLowTemp: UILabel!
    @IBOutlet weak var currHighTemp: UILabel!
    
    
    @IBOutlet weak var day1ConditionImageView: UIImageView!
    @IBOutlet weak var day1LowTemp: UILabel!
    @IBOutlet weak var day1HighTemp: UILabel!
    
    
    @IBOutlet weak var day2ConditionImageView: UIImageView!
    @IBOutlet weak var day2LowTemp: UILabel!
    @IBOutlet weak var day2HighTemp: UILabel!
    
    
    @IBOutlet weak var day3ConditionImageView: UIImageView!
    @IBOutlet weak var day3LowTemp: UILabel!
    @IBOutlet weak var day3HighTemp: UILabel!
    
    
    @IBOutlet weak var day4ConditionImageView: UIImageView!
    @IBOutlet weak var day4LowTemp: UILabel!
    @IBOutlet weak var day4HighTemp: UILabel!
    
    
    
    @IBAction func locationButtonPressed(_ sender: UIButton) {
        backgroundImage.image = UIImage(named: "sunny")
        locationManager.requestLocation()
    }
    
    //use built-in image processer
    let context = CIContext()
    
    
    var weatherManager = WeatherManager()
    var photoManager = PhotoManager()
    let locationManager = CLLocationManager()
    var forecastManager = ForecastManager()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        photoManager.delegate = self
        weatherManager.delegate = self
        searchTextField.delegate = self
        forecastManager.delegate = self
        
        forecastView.layer.cornerRadius = 35
    }
    
    
}

//MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate{
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
            photoManager.fetchPhotos(cityName: city)
            forecastManager.fetchForecast(cityName: city)
            searchTextField.text = ""
        }
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type something.."
            return false
        }
    }
    
}

//MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
            self.weatherCondition.text = weather.description
            self.currLowTemp.text = String(weather.tempMin)
            self.currHighTemp.text = String(weather.tempMax)
            self.currConditionImageView.image = UIImage(systemName: weather.conditionName)
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

//MARK: - CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
            forecastManager.fetchForecast(latitude: lat, longtitude: lon)
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

//MARK: - PhotoManagerDelegate

extension WeatherViewController: PhotoManagerDelegate{
    func didUpdatePhoto(_ photoManager: PhotoManager, photo: PhotoModel) {
        DispatchQueue.main.async {
            self.backgroundImage.loadFrom(URLAddress: "\(photo.photoURL)")
        }
    }
    
    func didFailWithPhotoError(error: Error) {
        print(error)
    }
}

//MARK: - ForecastManagerDelegate

extension WeatherViewController: ForecastManagerDelegate{
    func didUpdateForecast(_ forecastManager: ForecastManager, forecast: ForecastModel) {
        DispatchQueue.main.async {
            self.day1ConditionImageView.image = UIImage(systemName: forecast.conditionName1)
            self.day1LowTemp.text = String(Int(forecast.firstDayLow))
            self.day1HighTemp.text = String(Int(forecast.firstDayHigh))
            
            self.day2ConditionImageView.image = UIImage(systemName: forecast.conditionName2)
            self.day2LowTemp.text = String(Int(forecast.secondDayLow))
            self.day2HighTemp.text = String(Int(forecast.secondDayHigh))
            
            self.day3ConditionImageView.image = UIImage(systemName: forecast.conditionName3)
            self.day3LowTemp.text = String(Int(forecast.thirdDayLow))
            self.day3HighTemp.text = String(Int(forecast.thirdDayHigh))
            
            self.day4ConditionImageView.image = UIImage(systemName: forecast.conditionName4)
            self.day4LowTemp.text = String(Int(forecast.forthDayLow))
            self.day4HighTemp.text = String(Int(forecast.forthDayHigh))
            
        }
    }
    
    func didFailWithForecastError(error: Error){
        print(error)
    }

}
