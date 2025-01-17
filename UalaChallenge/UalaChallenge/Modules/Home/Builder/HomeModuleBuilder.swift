//
//  HomeModuleBuilder.swift
//  UalaChallenge
//
//  Created by Fede Flores on 16/01/2025.
//

import UIKit
import SwiftUI

class HomeModuleBuilder {
    
    private enum Wording {
        static let homeViewTitle: String = "Uala Places"
    }
    
    static func build() -> HomeView {
        let homeViewModel: any HomeViewModelProtocol = HomeViewModel()
        homeViewModel.provider = NetworkProvider()
        let homeView: HomeView = HomeView(viewModel: homeViewModel as? HomeViewModel ?? HomeViewModel())
        return homeView
    }
    
}
