//
//  Copyright © 2018 Dyson
//

import XCTest

import RxCocoa
import RxSwift
import RxTest

@testable import ConnectivityRemoteTest

final class BravoViewModelTests: XCTestCase {
    
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
    
    func testViewDidLoad_PayloadStoreIsUpdatedWhenFetchSucceeds() {
        let fetcher = MockJSONFetcher()
        let store = MockPayloadStore()
        let viewModel = BravoViewModel(dataFetcher: fetcher, dataStore: store)

        let storeExpectation = expectation(description: "Payload Store Is Updated When Fetch Succeeds")
        
        store.payloadUpdatedCallback = { payload in
            if payload != nil {
                storeExpectation.fulfill()
            }
        }
        SharingScheduler.mock(scheduler: testScheduler) {
            viewModel.viewDidLoad()
            testScheduler.scheduleAt(100) { [fetcher] in
                fetcher.completionHandler?(.success(data: Constants.testData))
            }
            testScheduler.start()
        }
        
        waitForExpectations(timeout: 0.1)
    }
    
    func testTextIsUpdatedWhenFetchFails() {
        let observer = testScheduler.createObserver(String.self)
        
        let fetcher = MockJSONFetcher()
        let viewModel = BravoViewModel(dataFetcher: fetcher, dataStore: MockPayloadStore())
        viewModel.titleText.drive(observer).disposed(by: disposeBag)
        
        SharingScheduler.mock(scheduler: testScheduler) {
            viewModel.viewDidLoad()
            testScheduler.scheduleAt(100) { [fetcher] in
                fetcher.completionHandler?(.failure(error: Error.test))
            }
            testScheduler.start()
        }
        
        let expectedEvents: [Recorded<Event<String>>] = [
            .next(0, ""),
            .next(100, BravoViewModel.Strings.Failure.title),
        ]
        
        XCTAssertEqual(observer.events, expectedEvents)
    }
    
    func testButtonIsDisabledWhenFetchFails() {
        let observer = testScheduler.createObserver(Bool.self)
        
        let fetcher = MockJSONFetcher()
        let viewModel = BravoViewModel(dataFetcher: fetcher, dataStore: MockPayloadStore())
        viewModel.buttonEnabled.drive(observer).disposed(by: disposeBag)
        
        SharingScheduler.mock(scheduler: testScheduler) {
            viewModel.viewDidLoad()
            testScheduler.scheduleAt(100) { [fetcher] in
                fetcher.completionHandler?(.failure(error: Error.test))
            }
            testScheduler.start()
        }
        
        let expectedEvents: [Recorded<Event<Bool>>] = [
            .next(0, false)
        ]
        
        XCTAssertEqual(observer.events, expectedEvents)
    }
    
    func testCompletionHandlerIsCalledWhenButtonIsPressed() {
        let completionHandlerCalled = expectation(description: "Completion handler should be called")
        
        let viewModel = BravoViewModel(dataFetcher: MockJSONFetcher(),
                                       dataStore: MockPayloadStore())

        viewModel.completionHandler = {
            completionHandlerCalled.fulfill()
        }

        viewModel.nextButtonPressed()

        waitForExpectations(timeout: 0)
    }
}

private enum Error: Swift.Error, LocalizedError {
    
    case test
    
    var errorDescription: String? {
        return "test"
    }
}

// MARK: - Constants

private extension BravoViewModelTests {
    
    struct Constants {
    
        private static let testJSON = """
        {"coord":{"lon":-2.1,"lat":51.58},"weather":[{"id":521,"main":"Rain","description":"shower rain","icon":"09d"}],"base":"stations","main":{"temp":280.93,"pressure":1001,"humidity":57,"temp_min":278.15,"temp_max":283.71},"visibility":10000,"wind":{"speed":2.6,"deg":270},"clouds":{"all":20},"dt":1554216663,"sys":{"type":1,"id":1363,"message":0.0116,"country":"GB","sunrise":1554183726,"sunset":1554230504},"id":2643146,"name":"Malmesbury","cod":200}
        """
        
        static let testData = testJSON.data(using: .utf8)!
    }
}

// MARK: - Mocks

final class MockJSONFetcher: DataFetcher {
    var completionHandler: ((FetchStatus) -> Void)? = nil
    
    func fetch(completion: @escaping (FetchStatus) -> Void) {
        completionHandler = completion
    }
    
}


final class MockPayloadStore: PayloadStore {
    
    var payloadUpdatedCallback: ((WeatherPayload?) -> Void)?
    
    var payload: WeatherPayload? {
        didSet {
            payloadUpdatedCallback?(payload)
        }
    }
}
