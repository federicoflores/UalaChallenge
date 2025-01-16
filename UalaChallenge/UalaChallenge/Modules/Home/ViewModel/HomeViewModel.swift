//
//  HomeViewModel.swift
//  UalaChallenge
//
//  Created by Fede Flores on 16/01/2025.
//

import Foundation

protocol HomeViewModelProtocol: ObservableObject {
    func fetchPlaces()
}

class HomeViewModel: HomeViewModelProtocol {
    
    enum HomeState {
        case loading
        case success
        case error
    }
    
    let provider: NetworkProvider = NetworkProvider()
    
    @Published var homeState: HomeState = .loading {
        didSet {
            print(homeState)
        }
    }
    lazy var placesList: [UalaPlace] = []
    
    func fetchPlaces() {
        homeState = .loading
        Task {
            do {
                let ualaPlaces: [UalaPlace] = try await provider.getDecodable()
                await MainActor.run {
                    placesList.append(contentsOf: ualaPlaces)
                    homeState = .success
                }
            } catch {
                homeState = .error
            }
        }
    }
}
