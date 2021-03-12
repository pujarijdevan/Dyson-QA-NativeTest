//
//  Copyright © 2018 Dyson
//

import XCTest

import RxCocoa
import RxSwift
import RxTest

@testable import ConnectivityRemoteTest

final class AlphaViewModelTests: XCTestCase {
    
    private let testScheduler = TestScheduler(initialClock: 0)
    
    private let mockReachability = MockReachabilityMonitor()
    private var viewModel: AlphaViewModel!
    private var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        viewModel = AlphaViewModel(reachabilityMonitor: mockReachability)
        disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        disposeBag = nil
        viewModel = nil
        super.tearDown()
    }
    
    func testTextIsUpdatedWhenReachabilityChanges() {
        let observer = testScheduler.createObserver(String.self)
        viewModel.titleText.drive(observer).disposed(by: disposeBag)
        
        SharingScheduler.mock(scheduler: testScheduler) {
            testScheduler.scheduleAt(100) { [mockReachability] in mockReachability.statusSubject.on(.next(true)) }
            testScheduler.scheduleAt(200) { [mockReachability] in mockReachability.statusSubject.on(.error(Error.test)) }
            testScheduler.start()
        }

        let expectedEvents: [Recorded<Event<String>>] = [
            .next(0, AlphaViewModel.Strings.Failure.title),
            .next(100, AlphaViewModel.Strings.Success.title),
            .next(200, AlphaViewModel.Strings.Failure.title),
            .completed(200)
        ]
        
        XCTAssertEqual(observer.events, expectedEvents)
    }
    
    func testButtonEnabledStateIsUpdatedWhenReachabilityChanges() {
        let observer = testScheduler.createObserver(Bool.self)
        viewModel.buttonEnabled.drive(observer).disposed(by: disposeBag)
        
        SharingScheduler.mock(scheduler: testScheduler) {
            testScheduler.scheduleAt(100) { [mockReachability] in mockReachability.statusSubject.on(.next(true)) }
            testScheduler.scheduleAt(200) { [mockReachability] in mockReachability.statusSubject.on(.error(Error.test)) }
            testScheduler.start()
        }
        
        let expectedEvents: [Recorded<Event<Bool>>] = [
            .next(0, false),
            .next(100, true),
            .next(200, false),
            .completed(200)
        ]
        
        XCTAssertEqual(observer.events, expectedEvents)
    }
    
    func testCompletionHandlerIsCalledWhenNextButtonTapped() {
        let completionHandlerCalled = expectation(description: "Completion handler should be called")
        
        viewModel.completionHandler = {
            completionHandlerCalled.fulfill()
        }
        
        viewModel.nextButtonPressed()
        
        waitForExpectations(timeout: 0)
    }
}

private enum Error: Swift.Error {
    case test
}

// MARK: - Mocks

private final class MockReachabilityMonitor: ReachabilityMonitoring {
    
    let reachabilityStatus: Observable<Bool>
    let statusSubject: BehaviorSubject<Bool>
    
    init(initialStatus: Bool = false) {
        statusSubject = BehaviorSubject<Bool>(value: initialStatus)
        reachabilityStatus = statusSubject.asObservable()
    }
}
