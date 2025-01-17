//
//  Navigator.swift
//  UalaChallenge
//
//  Created by Fede Flores on 17/01/2025.
//

import SwiftUI
import MapKit

public protocol Router {

    associatedtype V: View

    @ViewBuilder
    func view() -> V
}

enum AppRoute: Router {

    case homeScreen
    case mapScreen(place: UalaPlace)

    @ViewBuilder
    func view() -> some View {
        switch self {
        case .homeScreen:
            HomeModuleBuilder.build()
        case .mapScreen(let place):
            MapViewModuleBuilder.build(place: place)
        }
    }
}

class AppNavigation {

    static var shared = AppNavigation(startingRoute: .homeScreen)
    let startingRoute: AppRoute

    init(navigationController: UINavigationController = .init(), startingRoute: AppRoute) {
        self.startingRoute = startingRoute
    }

    func startingViewController() -> UIViewController{
        let view = startingRoute.view()
        let navigationController: UINavigationController = UINavigationController()
        let viewWithCoordinator = view.environmentObject(navigationController)
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        navigationController.setViewControllers([viewController], animated: false)
        return navigationController
    }

    func present(_ route: AppRoute, animated: Bool = true, source: UINavigationController) {
        let view = route.view()
        let destinationNavigationController: UINavigationController = .init()
        let viewWithNavigator = view.environmentObject(destinationNavigationController)
        let viewController = UIHostingController(rootView: viewWithNavigator)
        destinationNavigationController.modalPresentationStyle = .fullScreen
        destinationNavigationController.setViewControllers([viewController], animated: animated)
        source.present(destinationNavigationController, animated: animated)
    }

    func navigate(_ route: AppRoute, animated: Bool = true, source: UINavigationController) {
        let view = route.view()
        let viewWithNavigator = view.environmentObject(source)
        let viewController = UIHostingController(rootView: viewWithNavigator)
        source.pushViewController(viewController, animated: animated)
    }

    func presentModally(_ route: AppRoute, animated: Bool = true, source: UINavigationController) {
        let view = route.view()
        let destinationNavigationController: UINavigationController = .init()
        let viewWithNavigator = view.environmentObject(destinationNavigationController)
        let viewController = UIHostingController(rootView: viewWithNavigator)
        destinationNavigationController.modalPresentationStyle = .formSheet
        destinationNavigationController.setViewControllers([viewController], animated: animated)
        source.present(destinationNavigationController, animated: animated)
    }
}
