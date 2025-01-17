//
//  HomeViewModel.swift
//  UalaChallenge
//
//  Created by Fede Flores on 16/01/2025.
//

import Foundation

protocol HomeViewModelProtocol: ObservableObject {
    func fetchPlaces()
    func setUalaPlaces(input: String, onlyFavoritesIsOn: Bool) -> [UalaPlace]
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
    private lazy var placesList: [UalaPlace] = []
    var fileteredPlaces: [UalaPlace] = []
    
    func fetchPlaces() {
        homeState = .loading
        Task {
            do {
                var ualaPlaces: [UalaPlace] = try await provider.getDecodable()
                ualaPlaces = ualaPlaces.sorted { $0.name.lowercased() < $1.name.lowercased() }
                placesList.append(contentsOf: ualaPlaces)
                await MainActor.run {
                    homeState = .success
                }
            } catch {
                homeState = .error
            }
        }
    }
    
    func setUalaPlaces(input: String, onlyFavoritesIsOn: Bool) -> [UalaPlace] {
        guard !input.isEmpty else {
            guard onlyFavoritesIsOn else {
                return placesList
            }
            fileteredPlaces = placesList.filter { $0.isFavorite }
            return fileteredPlaces
        }
        
        fileteredPlaces = placesList.filter { $0.name.lowercased().hasPrefix(input.lowercased())}
        if onlyFavoritesIsOn {
            fileteredPlaces = fileteredPlaces.filter { $0.isFavorite }
        }
        return fileteredPlaces
    }
}
