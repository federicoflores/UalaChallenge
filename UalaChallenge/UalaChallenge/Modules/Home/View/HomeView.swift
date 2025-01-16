//
//  HomeView.swift
//  UalaChallenge
//
//  Created by Fede Flores on 16/01/2025.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel:  HomeViewModel = HomeViewModel()
    
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
                ForEach(viewModel.placesList, id: \.self) { place in
                    PlaceRowView(
                        ualaPlace: place,
                        isFavorite: place.isFavorite,
                        completion: { isFavorite in
                            place.isFavorite = isFavorite
                            //TODO:: Persist data
                        })
                }
            }
        }
    }
        
    
}

#Preview {
    HomeView()
}
