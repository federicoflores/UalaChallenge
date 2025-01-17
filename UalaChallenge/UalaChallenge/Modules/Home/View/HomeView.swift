//
//  HomeView.swift
//  UalaChallenge
//
//  Created by Fede Flores on 16/01/2025.
//

import SwiftUI

struct HomeView: View {
    
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
        }, title: "Ups", subtitle:"There's been an error", buttonText: "Try again")
    }
    
    fileprivate var successView: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                Toggle(isOn: $showFavoritesOnly) {
                    Text("Favorites only")
                        .font(.headline)
                }
                .padding(24)
                ForEach(viewModel.setUalaPlaces(input: searchInput, onlyFavoritesIsOn: showFavoritesOnly), id: \.self) { place in
                    PlaceRowView(
                        ualaPlace: place,
                        isFavorite: place.isFavorite,
                        completion: { isFavorite in
                            place.isFavorite = isFavorite
                            //TODO:: Persist data
                        })
                    .onTapGesture {
                        navigationController.pushViewController(MapViewModuleBuilder.build(place: place), animated: true)
                    }
                }
            }
            .searchable(text: $searchInput, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search")
        }
    }
}

#Preview {
    HomeView()
}
