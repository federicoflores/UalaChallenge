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
    
    static func build() -> UINavigationController {
        let navigationController = UINavigationController()
        let homeViewModel: any HomeViewModelProtocol = HomeViewModel()
        let homeView: HomeView = HomeView(viewModel: homeViewModel as? HomeViewModel ?? HomeViewModel())
        let viewWithCoordinator = homeView.environmentObject(navigationController)
        let hostingController = UIHostingController(rootView: viewWithCoordinator)
        hostingController.title = Wording.homeViewTitle
        navigationController.setViewControllers([hostingController], animated: true)
        return navigationController
    }
}
