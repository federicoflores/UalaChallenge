//
//  NetworkProvider.swift
//  UalaChallenge
//
//  Created by Fede Flores on 16/01/2025.
//


import UIKit

protocol NetworkProviderProtocol {
    func getDecodable<T: Decodable>() async throws -> T
}

class NetworkProvider: NetworkProviderProtocol {
    
    private enum NetworkingError: Error {
        case decodingFailed(innerError: Error)
        case invalidStatusCode(statusCode: Int)
        case requestFailed(innerError: URLError)
        case otherError(innerError: Error)
    }
    
    fileprivate enum Constant {
        static let sesionConfigTimeIntervals: CGFloat = 20.0
    }
    
    init() {
        sessionConfig.timeoutIntervalForRequest = Constant.sesionConfigTimeIntervals
        sessionConfig.timeoutIntervalForResource = Constant.sesionConfigTimeIntervals
    }
    
    let sessionConfig = URLSessionConfiguration.default
    let cacheManager = CacheManager.shared.cache
    func getDecodable<T: Decodable>() async throws -> T {
                
        //TODO:: MOVE TO A SECRETS FILE AND CREATE A MANAGER TO HANDLE IT
        
        guard let url = URL(string: "https://gist.githubusercontent.com/hernan-uala/dce8843a8edbe0b0018b32e137bc2b3a/raw/0996accf70cb0ca0e16f9a99e0ee185fafca7af1/cities.json") else {
            throw URLError(.badURL)
        }
        do {
            if let cached = cacheManager[url.absoluteString as NSString], let decodable = cached as? T {
                return decodable
            }
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                throw NetworkingError.invalidStatusCode(statusCode: -1)
            }
            guard (200...299).contains(statusCode) else {
                throw NetworkingError.invalidStatusCode(statusCode: statusCode)
            }
            let model = try JSONDecoder().decode(T.self, from: data)
            cacheManager[url.absoluteString as NSString] = model
            return model
        } catch {
            throw error
        }
    }
}

