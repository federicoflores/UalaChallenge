//
//  HomeView.swift
//  UalaChallenge
//
//  Created by Fede Flores on 16/01/2025.
//

import SwiftUI

struct HomeView: View {
    
    private enum Constants {
        static let tooglePadding: CGFloat = 24
    }
    
    private enum Localizables {
        static let errorViewTitle = "Ups"
        static let errorViewSubtitle = "There's been an error"
        static let errorViewButtonTitle = "Try again"
        static let toggleText = "Favorites only"
        static let searchBarPrompt = "Search"
    }
    
    @EnvironmentObject var navigationController: UINavigationController
    @ObservedObject var viewModel:  HomeViewModel = HomeViewModel()
    @State private var searchInput: String = ""
    @State private var showFavoritesOnly = false {
        didSet {
            print(showFavoritesOnly)
        }
    }
    
    var body: some View {
        VStack {
            switch viewModel.homeState {
            case .error:
                errorView
            case .loading:
                LoaderView()
            case .success:
                successView
            }
        }
        .task {
            viewModel.fetchPlaces()
        }
    }
    
    fileprivate var errorView: some View {
        ErrorView(action: {
            viewModel.fetchPlaces()
        }, title: Localizables.errorViewTitle, subtitle: Localizables.errorViewSubtitle, buttonText: Localizables.errorViewButtonTitle)
    }
    
    fileprivate var successView: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                Toggle(isOn: $showFavoritesOnly) {
                    Text(Localizables.toggleText)
                        .font(.headline)
                }
                .padding(Constants.tooglePadding)
                ForEach(viewModel.setUalaPlaces(input: searchInput, onlyFavoritesIsOn: showFavoritesOnly), id: \.self) { place in
                    PlaceRowView(
                        ualaPlace: place,
                        isFavorite: place.isFavorite,
                        completion: { isFavorite in
                            place.isFavorite = isFavorite
                            viewModel.persistPlaceId(id: place.id)
                        })
                    .onTapGesture {
                        navigationController.pushViewController(MapViewModuleBuilder.build(place: place), animated: true)
                    }
                }
            }
            .searchable(text: $searchInput, placement: .navigationBarDrawer(displayMode: .always), prompt: Localizables.searchBarPrompt)
        }
    }
}

#Preview {
    HomeView()
}
