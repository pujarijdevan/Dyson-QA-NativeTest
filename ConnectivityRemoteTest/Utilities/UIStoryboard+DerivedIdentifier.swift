//
//  Copyright © Dyson 2018
//

import UIKit

extension UIStoryboard {
    
    /// Instantiates and returns the view controller of the expected type with the identifier derived from the type.
    ///
    /// - Parameter identifier: An identifier string that uniquely identifies the view controller in the storyboard
    ///     file. The identifier can be set for a given view controller in Interface Builder when configuring the
    ///     storyboard file. This identifier is not a property of the view controller object itself and is used only by
    ///     the storyboard file to locate the view controller. The default value is derived from the view controller's
    ///     class.
    /// - Returns: The view controller of the expected type. If no view controller is associated with the derived
    ///     identifier or the type of the view controller cannot be casted to the expected type, the method will throw
    ///     an exception.
    func instantiateViewController<T: UIViewController>(withIdentifier identifier: String = String(describing: T.self)) -> T {
        guard let viewController = instantiateViewController(withIdentifier: identifier) as? T else {
            fatalError("Found mismatched view controller type with identifier '\(identifier)'")
        }
        return viewController
    }
}
