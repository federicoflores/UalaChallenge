//
//  UalaPlace.swift
//  UalaChallenge
//
//  Created by Fede Flores on 16/01/2025.
//

import Foundation

class UalaPlace: Decodable, Identifiable, Hashable {
    
    let country: String
    let name: String
    let id: Int
    let coordinate: Coordinate
    var isFavorite: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case country, name
        case id = "_id"
        case coordinate = "coord"
    }
    
    init(country: String, name: String, id: Int, coordinate: Coordinate, isFavorite: Bool) {
        self.country = country
        self.name = name
        self.id = id
        self.coordinate = coordinate
        self.isFavorite = isFavorite
    }
    
    static func == (lhs: UalaPlace, rhs: UalaPlace) -> Bool {
        lhs.id == rhs.id
    }
    
    
    nonisolated public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
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
