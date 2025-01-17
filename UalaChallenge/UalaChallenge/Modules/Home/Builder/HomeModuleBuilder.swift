//
//  HomeModuleBuilder.swift
//  UalaChallenge
//
//  Created by Fede Flores on 16/01/2025.
//

import UIKit
import SwiftUI

class HomeModuleBuilder {
    static func build() -> some View {
        let homeViewModel: any HomeViewModelProtocol = HomeViewModel()
        let homeView: HomeView = HomeView(viewModel: homeViewModel as? HomeViewModel ?? HomeViewModel())
//        let hosting = UIHostingController(rootView: homeView)
//        hosting.title = "Home View"
        return homeView
    }
}
