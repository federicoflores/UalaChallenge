//
//  UINavigationController+Extensions.swift
//  UalaChallenge
//
//  Created by Fede Flores on 17/01/2025.
//

import UIKit

extension UINavigationController: @retroactive ObservableObject {

    func navigateTo(route: AppRoute) {
        AppNavigation.shared.navigate(route, source: self)
    }

    func presentScreen(route: AppRoute) {
        AppNavigation.shared.present(route, source: self)
    }

    func pop() {
        popViewController(animated: true)
    }

    func popToRoot() {
        popToRootViewController(animated: true)
    }
}

