//
//  NetworkProviderStub.swift
//  UalaChallenge
//
//  Created by Fede Flores on 17/01/2025.
//


 import Foundation
 @testable import UalaChallenge

 class NetworkProviderStub: NetworkProviderProtocol {
     
     func getDecodable<T: Decodable>() async throws -> T {
         
         let model: [UalaPlace]? = JSONLoader().ualaPlacesResponse(ualaPlacesResponses: .homePlaces)
         return model as! T         
     }
     
 }


