//
//  Copyright © 2018 Dyson
//

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private lazy var mainCoordinator = MainCoordinator()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        if NSClassFromString("XCTestCase") == nil {
            window?.rootViewController = mainCoordinator.rootViewController
        }
        return true
    }
}
