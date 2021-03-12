//
//  Copyright © 2018 Dyson
//

import RxSwift
import Reachability

/// Provides network reachability monitoring functionality
protocol ReachabilityMonitoring {
    
    /// An observable that emits next events when network reachability status changes
    var reachabilityStatus: Observable<Bool> { get }
}

final class ReachabilityMonitor: ReachabilityMonitoring {

    let reachabilityStatus: Observable<Bool>
    
    private let reachability: Reachability
    
    init?(hostName: String = WeatherDataFetcher.Constants.host) {
        guard let reachability = Reachability(hostname: hostName) else {
            return nil
        }
        
        reachabilityStatus = Observable.create { observer in
            reachability.whenReachable = { _ in
                return observer.onNext(true)
            }
            reachability.whenUnreachable = { _ in
                return observer.onNext(false)
            }
            
            do {
                try reachability.startNotifier()
            } catch {
                observer.onError(error)
            }

            return Disposables.create {
                reachability.stopNotifier()
            }
        }
        
        self.reachability = reachability
    }
}
