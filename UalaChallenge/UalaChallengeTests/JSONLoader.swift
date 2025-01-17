//
//  JSONLoader.swift
//  UalaChallenge
//
//  Created by Fede Flores on 17/01/2025.
//

 import Foundation
 @testable import UalaChallenge

 class JSONLoader {
     
     enum UalaPlacesResponses: String {
         case homePlaces = "homePlaces"
     }
     
     func ualaPlacesResponse<T: Decodable>(ualaPlacesResponses: UalaPlacesResponses) -> T? {
         if let path = Bundle.main.path(forResource: ualaPlacesResponses.rawValue, ofType: "json") {
         do {
         let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
             let item = try? JSONDecoder().decode(T.self, from: data)
             return item
         } catch {
             print(error)
              }
         }
         return nil
     }
     
}
