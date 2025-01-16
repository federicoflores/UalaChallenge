//
//  UalaPlace.swift
//  UalaChallenge
//
//  Created by Fede Flores on 16/01/2025.
//

import Foundation

struct UalaPlace: Decodable {
    
    let country: String
    let name: String
    let id: Int
    let coordinate: Coordinate
    
    enum CodingKeys: String, CodingKey {
        case country, name
        case id = "_id"
        case coordinate = "coord"
    }
}

struct Coordinate: Decodable, Hashable {
    let longitude: Float
    let latitude: Float
    
    enum CodingKeys: String, CodingKey {
        case longitude = "lon"
        case latitude = "lat"
    }
}
