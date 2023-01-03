//
//  PhotoManager.swift
//  Clim8-ios
//
//  Created by bo zhong on 12/21/22.
//

import Foundation

protocol PhotoManagerDelegate{
    func didUpdatePhoto(_ photoManager: PhotoManager, photo: PhotoModel)
    func didFailWithPhotoError(error: Error)
}

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

