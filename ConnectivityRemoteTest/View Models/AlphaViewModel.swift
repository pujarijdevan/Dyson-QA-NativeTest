//
//  Copyright © 2018 Dyson
//

import RxSwift
import RxCocoa

final class AlphaViewModel: ViewModel {
    struct Strings {
        struct Success {
            static let title = "Connected"
            static let body = "You are connected to the internet"
            static let image = "Success"
        }
        struct Failure {
            static let title = "Unable To Connect"
            static let body = "An internet connection cannot be made"
            static let image = "Error"
        }
    }
    
    let titleText: Driver<String>    
    let bodyText: Driver<String>
    let iconImage: Driver<String>
    let buttonAlpha: Driver<CGFloat>
    let progressAnimating: Driver<Bool>
    
    private let reachabilityMonitor: ReachabilityMonitoring?
    
    init(reachabilityMonitor: ReachabilityMonitoring?) {
        self.reachabilityMonitor = reachabilityMonitor

        guard let reachability = reachabilityMonitor?.reachabilityStatus else {
            preconditionFailure("No reachability")
        }
        
        let reachabilityDriver = reachability.asDriver(onErrorJustReturn: false)
        self.buttonAlpha = reachabilityDriver.map { $0 ? 1 : 0.7 }
        self.titleText = reachabilityDriver
            .map { $0 ? Strings.Success.title : Strings.Failure.title }
        self.bodyText = reachabilityDriver
            .map { $0 ? Strings.Success.body : Strings.Failure.body }
        self.iconImage = reachabilityDriver
            .map { $0 ? Strings.Success.image : Strings.Failure.image }
        self.progressAnimating = reachabilityDriver
            .startWith(true)
            .map { _ in false }
    }

    func nextButtonPressed() {
        completionHandler()
    }
}
