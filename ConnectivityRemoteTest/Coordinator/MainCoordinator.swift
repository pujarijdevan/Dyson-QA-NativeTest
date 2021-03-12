//
//  Copyright © 2018 Dyson
//

import UIKit

protocol Coordinator {
    var rootViewController: UIViewController { get }
}

class MainCoordinator: Coordinator {
    
    private let weatherDataFetcher: DataFetcher
    private let dataStore: PayloadStore
    private let reachabilityMonitor: ReachabilityMonitor
    
    private let storyboard: UIStoryboard
    
    private(set) lazy var rootViewController: UIViewController = {
        let navigationController =
            UINavigationController(rootViewController: self.alphaViewController)
        navigationController.navigationBar.barStyle = .black
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.tintColor = UIColor.white
        navigationController.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont(name: "Futura-Medium", size: 17)
        ]
        return navigationController
    }()
    
    private lazy var alphaViewController: UIViewController = {
        let alphaViewModel = AlphaViewModel(reachabilityMonitor: reachabilityMonitor)
        alphaViewModel.completionHandler = { [unowned self] in
            self.rootViewController.push(self.bravoViewController)
        }
        
        let viewController: AlphaViewController = storyboard.instantiateViewController()
        viewController.viewModel = alphaViewModel
        
        return viewController
    }()
    
    private lazy var bravoViewController: UIViewController = {
        let bravoViewModel = BravoViewModel(
            dataFetcher: weatherDataFetcher,
            dataStore: dataStore)
        bravoViewModel.completionHandler = { [unowned self] in
            self.rootViewController.push(self.charlieViewController)
        }

        let viewController: BravoViewController = storyboard.instantiateViewController()
        viewController.viewModel = bravoViewModel
        
        return viewController
    }()
    
    private lazy var charlieViewController: UIViewController = {
        let charlieViewModel = CharlieViewModel(dataStore: dataStore)
        charlieViewModel.completionHandler = { [unowned self] in
            self.testCompleted()
        }

        let viewController: CharlieViewController = storyboard.instantiateViewController()
        viewController.viewModel = charlieViewModel
        
        return viewController
    }()
    
    // TODO: call this method when `CharlieViewModel` is completed.
    private func testCompleted() {
        let alert = UIAlertController(title: "Finished", message: "Well done", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
        self.rootViewController.present(alert, animated: true)
    }
    
    init() {
        self.storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.weatherDataFetcher = WeatherDataFetcher(location: .singapore)
        self.dataStore = UserDefaultsPayloadStore()
        self.reachabilityMonitor = ReachabilityMonitor()!
    }
}

private extension UIViewController {
    
    func push(_ viewController: UIViewController) {
        topViewController.show(viewController, sender: self)
    }

    private var topViewController: UIViewController {
        var topViewController: UIViewController?
        
        if let presentedViewController = presentedViewController {
            topViewController = presentedViewController
        } else if let navigationController = self as? UINavigationController {
            topViewController = navigationController.visibleViewController
        } else if let tabBarController = self as? UITabBarController {
            topViewController = tabBarController.selectedViewController
        }
        
        return topViewController ?? self
    }
}
