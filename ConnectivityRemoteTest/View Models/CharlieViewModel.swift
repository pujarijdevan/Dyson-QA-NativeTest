//
//  Copyright © 2018 Dyson
//

import RxCocoa
import RxSwift

extension Double {
    var kelvinToCelsius: Double {
        return self - 273.15
    }
}

class CharlieViewModel: ViewModel {
    struct Strings {
        static let weatherFailure = "Weather Not Available"
        static let temperatureFailure = "Temperature Not Available"
    }
    
    var weatherText: Driver<String>
    var temperatureText: Driver<String>
    var buttonEnabled: Driver<Bool>
    var iconImage: Driver<String?>
    
    init(dataStore: PayloadStore) {
        buttonEnabled = Driver.just(dataStore.payload != nil)
        let weatherDescription = dataStore.payload?.weather.first?.description
            ?? Strings.weatherFailure
        let temperature = dataStore.payload?.metrics.temperature
        let temperatureDescription = temperature.flatMap {
                String(format: "%.2f°C", $0.kelvinToCelsius)
            }
            ?? Strings.temperatureFailure
        let icon = dataStore.payload?.weather.first?.icon

        weatherText = Driver.just(weatherDescription)
        temperatureText = Driver.just(temperatureDescription)
        iconImage = Driver.just(icon)
    }
    
    func nextButtonPressed() {
        completionHandler()
    }
}
