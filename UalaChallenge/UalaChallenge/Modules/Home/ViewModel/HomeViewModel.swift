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
    func persistPlaceId(id: Int)
}

class HomeViewModel: HomeViewModelProtocol {
    
    private enum Constants {
        static let favoriteIdKey = "persistedPlacesId"
    }
    
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
    lazy var fileteredPlaces: [UalaPlace] = []
    
    func fetchPlaces() {
        guard placesList.isEmpty else { return }
        homeState = .loading
        Task {
            do {
                var ualaPlaces: [UalaPlace] = try await provider.getDecodable()
                updatePersistedFavoritesValuesifNeeded(ualaPlaces: ualaPlaces)
                ualaPlaces.sort { $0.name.lowercased() < $1.name.lowercased() }
                placesList.append(contentsOf: ualaPlaces)
                await MainActor.run {
                    homeState = .success
                }
            } catch {
                homeState = .error
            }
        }
    }
    
    private func updatePersistedFavoritesValuesifNeeded(ualaPlaces: [UalaPlace]) {
        guard let persistedPlacesId = UserDefaults.standard.array(forKey: Constants.favoriteIdKey) as? [Int] else { return }
        for placeId in persistedPlacesId {
            if let index = ualaPlaces.firstIndex(where: {$0.id == placeId}) {
                ualaPlaces[index].isFavorite = true
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
    
    func persistPlaceId(id: Int) {
        var persistedPlacesId = UserDefaults.standard.array(forKey: Constants.favoriteIdKey) as? [Int]
        persistedPlacesId = persistedPlacesId == nil ? [Int]() : persistedPlacesId
        if let persistedPlaceId = persistedPlacesId, persistedPlaceId.contains(id) {
            persistedPlacesId?.removeAll(where: { $0 == id })
        } else {
            persistedPlacesId?.append(id)
        }
        UserDefaults.standard.set(persistedPlacesId, forKey: Constants.favoriteIdKey)
    }
}
