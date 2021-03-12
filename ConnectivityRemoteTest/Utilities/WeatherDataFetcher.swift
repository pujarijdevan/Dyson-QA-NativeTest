//
//  Copyright © 2018 Dyson
//

import Alamofire
import RxSwift

enum WeatherLocation {
    case bristol
    case malmesbury
    case singapore
    
    var cityID: String {
        switch self {
        case .bristol:
            return "3333134"
        case .malmesbury:
            return "2643146"
        case .singapore:
            return "1880252"
        }
    }
}

final class WeatherDataFetcher: HttpDataFetcher {
    
    struct Constants {
        static let host = "api.openweathermap.org"
        static let apiKey = "908b2c408ebaae7d7bffa03362f6a10d"
    }
    private let cityID: String
    
    init(location: WeatherLocation) {
        self.cityID = location.cityID
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = Constants.host
        urlComponents.path = "/data/2.5/weather"
        urlComponents.queryItems = [
            URLQueryItem(name: "id", value: cityID),
            URLQueryItem(name: "APPID", value: Constants.apiKey)
        ]
        guard let url = try? urlComponents.asURL() else {
            preconditionFailure("Invalid URL for weather fetcher")
        }
        super.init(url: url)
    }
}
