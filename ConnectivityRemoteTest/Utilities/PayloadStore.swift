//
//  Copyright © 2018 Dyson
//

import Foundation

/// Provides storage functionality for `PayloadData`
protocol PayloadStore: class {
    
    /// Stored `Payload`
    var payload: WeatherPayload? { get set }
}

final class UserDefaultsPayloadStore: PayloadStore {
    
    var payload: WeatherPayload? {
        get {
            guard let data = userDefaults.data(forKey: Constants.userDefaultsKey) else {
                return nil
            }
            return try? decoder.decode(WeatherPayload.self, from: data)
        }
        set {
            if let value = newValue, let data = try? encoder.encode(value) {
                userDefaults.set(data, forKey: Constants.userDefaultsKey)
            } else {
                userDefaults.removeObject(forKey: Constants.userDefaultsKey)
            }
            userDefaults.synchronize()
        }
    }
    
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    private let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
}

// MARK: - Internal Constants

private extension UserDefaultsPayloadStore {
    struct Constants {
        static let userDefaultsKey = "PayloadDataStoreKey"
    }
}
