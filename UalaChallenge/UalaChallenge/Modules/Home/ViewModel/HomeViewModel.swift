//
//  HomeViewModel.swift
//  UalaChallenge
//
//  Created by Fede Flores on 16/01/2025.
//

import Foundation
import Combine

protocol HomeViewModelProtocol: AnyObject, ObservableObject {
    func fetchPlaces()
    func setUalaPlaces(input: String, onlyFavoritesIsOn: Bool) //Keep in protocol just for testing purposes
    var fileteredPlaces: [UalaPlace] { get set }
    func persistPlaceId(id: Int)
    func getPlaceList() -> [UalaPlace]
    var searchInput: String { get set }
    var provider: NetworkProviderProtocol? { get set }
    var showFavoritesOnly: Bool { get set }
}

class HomeViewModel: HomeViewModelProtocol {
    
    private enum Constants {
        static let favoriteIdKey = "persistedPlacesId"
        static let debounceTime: Int = 500
    }
    
    enum HomeState {
        case loading
        case success
        case error
    }
    
    var provider: NetworkProviderProtocol?
    
    @Published var homeState: HomeState = .loading
    @Published var searchInput: String = ""
    @Published var fileteredPlaces: [UalaPlace] = []
    @Published var showFavoritesOnly = false {
        didSet {
            setUalaPlaces(input: searchInput, onlyFavoritesIsOn: showFavoritesOnly)
        }
    }
    
    private lazy var placesList: [UalaPlace] = []
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $searchInput
            .debounce(for: .milliseconds(Constants.debounceTime), scheduler: RunLoop.main)
            .sink { [weak self] debouncedText in
                self?.setUalaPlaces(input: debouncedText, onlyFavoritesIsOn: self?.showFavoritesOnly ?? false)
            }
            .store(in: &cancellables)
    }
    
    
    func getPlaceList() -> [UalaPlace] {
        placesList
    }
    
    func fetchPlaces() {
        guard placesList.isEmpty else { return }
        homeState = .loading
        Task {
            do {
                guard let provider else { return }
                var ualaPlaces: [UalaPlace] = try await provider.getDecodable()
                updatePersistedFavoritesValuesifNeeded(ualaPlaces: ualaPlaces)
                ualaPlaces.sort { $0.name.lowercased() < $1.name.lowercased() }
                placesList.append(contentsOf: ualaPlaces)
                await MainActor.run {
                    fileteredPlaces = placesList
                }
                
                await MainActor.run {
                    homeState = .success
                }
            } catch {
                await MainActor.run {
                    homeState = .error
                }
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
    
    func setUalaPlaces(input: String, onlyFavoritesIsOn: Bool) {
        guard !input.isEmpty else {
            guard onlyFavoritesIsOn else {
                fileteredPlaces = placesList
                return
            }
            fileteredPlaces = placesList.filter { $0.isFavorite }
            return
        }
        
        fileteredPlaces = placesList.filter { $0.name.lowercased().hasPrefix(input.lowercased())}
        if onlyFavoritesIsOn {
            fileteredPlaces = fileteredPlaces.filter { $0.isFavorite }
        }
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
