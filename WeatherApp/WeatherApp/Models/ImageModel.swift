//
//  ImageModel.swift
//  WeatherApp
//
//  Created by Olimpia on 1/23/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
struct ImageModel: Codable {
    let hits: [Image]
}

struct Image: Codable {
    let largeImageURL: String
    let tags: String
    let user: String
    let favorites: Int
}
