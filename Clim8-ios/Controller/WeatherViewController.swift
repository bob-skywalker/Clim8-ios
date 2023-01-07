//
//  ViewController.swift
//  Clim8-ios
//
//  Created by bo zhong on 12/19/22.
//




import UIKit
import CoreLocation
import Shiny


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
    
    
    

    
    
    @IBAction func locationButtonPressed(_ sender: UIButton) {
        backgroundImage.image = UIImage(named: "sunny")
        locationManager.requestLocation()
    }
    
    //use built-in image processer
    let context = CIContext()
    
    
    var weatherManager = WeatherManager()
    var photoManager = PhotoManager()
    let locationManager = CLLocationManager()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        photoManager.delegate = self
        weatherManager.delegate = self
        searchTextField.delegate = self
        
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
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}


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
