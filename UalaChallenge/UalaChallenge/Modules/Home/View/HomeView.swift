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
                let _ = print("Success")
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
        
    
}

#Preview {
    HomeView()
}
