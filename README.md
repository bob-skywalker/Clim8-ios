# Clime8

[Clime8](https://apps.apple.com/us/app/clime8/id1662664856) Get the live weather forecast with automatic background rendering with this powerful app. See current and forecasted weather with our smart layout that updates as conditions change.  
**Key Features:**

* View current weather as well as forecasted weather for the city of your choice

* See the weather condition image render based on decoded Data from openWeatherAPI

* Background image automatically renders based on the city you choose.

* Always update to date and display accurate weather data as long as the API is available

## Technologies, Libraries, APIs

* Unsplashed Images API Database - fetch image based on user inputs

* OpenWeather API - fetch live weather data 

* UIKit, MVC design pattern, Delegate Protocol, JSON parser

**Front-end:**

* Swift
* UIKit
* Swift Struct
* Computed Properties
* StoryBoard
* Unsplash API
* OpenWeather API

**Module Bundler** 

* Cocoapod
* UIKit 
* UIImageView with async URL fetch functionality 

# Aplication Preview

## Clime8 Layout

![Clime8 Layout](https://i.postimg.cc/kGtP67Jw/Untitled-design.png)


## Code Snippet

**Swift Async fetch from Unsplash API server** 
```swift
  
struct PhotoManager{
    var delegate: PhotoManagerDelegate?
    
    let photoURL =
    "https://api.unsplash.com/search/photos?client_id=Pa7ds2qwm2k0cqOa4FALgC4fKya3isGxtlx7lB7h0PI"
    
    func fetchPhotos(cityName: String){
        let replaced = cityName.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
        let urlString = "\(photoURL)&query=\(replaced)"
        performImageRequest(with: urlString)
    }
    
    func performImageRequest(with urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
                if error != nil{
                    self.delegate?.didFailWithPhotoError(error: error!)
                    return
                }
                if let safeData = data {
                    if let photo = self.parsePhotoJSON(safeData){
                        self.delegate?.didUpdatePhoto(self, photo: photo)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parsePhotoJSON(_ photoData: Data) -> PhotoModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(PhotoData.self, from: photoData)
            if decodedData.results.count == 0 {
                print("no data loaded")
                return PhotoModel(photoURL: "https://i.postimg.cc/5y5kyB10/CITY-NOT-FOUND-1.png")
            }
            let photoURL = decodedData.results[0].urls.regular
            let photo = PhotoModel(photoURL: photoURL)
            return photo
            

        } catch {
            self.delegate?.didFailWithPhotoError(error: error)
            return nil
        }
    }
}
```
