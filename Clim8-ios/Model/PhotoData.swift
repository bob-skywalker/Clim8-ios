//
//  PhotoData.swift
//  Clim8-ios
//
//  Created by bo zhong on 12/21/22.
//

import Foundation

struct PhotoData: Codable{
    let results: [Result]
}

struct Result: Codable{
    let id: String
    let urls: URLS
}

struct URLS: Codable{
    let raw: String
    let regular: String
}
