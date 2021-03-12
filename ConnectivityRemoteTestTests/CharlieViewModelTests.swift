//
//  Copyright © 2018 Dyson
//

import XCTest

import RxCocoa
import RxSwift
import RxTest

@testable import ConnectivityRemoteTest

final class CharlieViewModelTests: XCTestCase {
    private let testScheduler = TestScheduler(initialClock: 0)
    private var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        disposeBag = nil
        super.tearDown()
    }
    
    private func assertFieldContentsFromPayload<T: Equatable>(
        testPayload: WeatherPayload?,
        expectedValue: T,
        bind: (CharlieViewModel, TestableObserver<T>) -> Void) {
        
        let observer = testScheduler.createObserver(T.self)
        
        let payloadStore = MockPayloadStore()
        payloadStore.payload = testPayload
        let viewModel = CharlieViewModel(dataStore: payloadStore)
        
        bind(viewModel, observer)
        
        SharingScheduler.mock(scheduler: testScheduler) {
            testScheduler.start()
        }
        
        let expectedEvents: [Recorded<Event<T>>] = [
            .next(0, expectedValue),
            .completed(0)
        ]
        
        XCTAssertEqual(observer.events, expectedEvents)
    }
    
    func testButtonIsDisabledWhenPayloadEmpty() {
        assertFieldContentsFromPayload(
            testPayload: nil,
            expectedValue: false)
        { viewModel, observer in
            viewModel.buttonEnabled.drive(observer).disposed(by: disposeBag)
        }
    }
    
    func testButtonIsEnabledWhenPayloadExists() {
        assertFieldContentsFromPayload(
            testPayload: Constants.testWeatherPayload,
            expectedValue: true)
        { viewModel, observer in
            viewModel.buttonEnabled.drive(observer).disposed(by: disposeBag)
        }
    }
    
    func testWeatherDescriptionFromPayload() {
        assertFieldContentsFromPayload(
            testPayload: Constants.testWeatherPayload,
            expectedValue: Constants.testWeatherPayload.weather[0].description)
        { viewModel, observer in
            viewModel.weatherText.drive(observer).disposed(by: disposeBag)
        }
    }
    
    func testWeatherDescriptionWhenPayloadEmpty() {
        assertFieldContentsFromPayload(
            testPayload: nil,
            expectedValue: "Weather Not Available")
        { viewModel, observer in
            viewModel.weatherText.drive(observer).disposed(by: disposeBag)
        }
    }
    
    func testTemperatureDescriptionFromPayload() {
        assertFieldContentsFromPayload(
            testPayload: Constants.testWeatherPayload,
            expectedValue: "7.78°C")
        { viewModel, observer in
            viewModel.temperatureText.drive(observer).disposed(by: disposeBag)
        }
    }
    
    func testTemperatureDescriptionWhenPayloadEmpty() {
        assertFieldContentsFromPayload(
            testPayload: nil,
            expectedValue: "Temperature Not Available")
        { viewModel, observer in
            viewModel.temperatureText.drive(observer).disposed(by: disposeBag)
        }
    }
}

private extension CharlieViewModelTests {
    struct Constants {
        static let testWeatherPayload = WeatherPayload(
            cityID: 2643146,
            city: "Malmesbury",
            coordinates: WeatherCoordinates(longitude: -2.1, latitude: 51.58),
            weather: [WeatherInfo(description: "shower rain")],
            metrics: WeatherMetrics(temperature: 280.93, humidity: 57))
    }
}
