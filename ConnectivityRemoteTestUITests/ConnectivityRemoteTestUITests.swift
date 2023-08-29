//
//  Copyright © Dyson 2021
//

import XCTest

class ConnectivityRemoteTestUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        XCTAssert(app.staticTexts["Connectivity"].exists)
              // Verify icon
              XCTAssert(app.staticTexts["Connected"].exists)
              XCTAssert(app.staticTexts["You are connected to the internet"].exists)
              XCTAssert(app.staticTexts["Fetch Data"].exists)

              app.buttons["Fetch Data"].tap()

              XCTAssert(app.staticTexts["Data Collection"].exists)
              // Verify icon
        //      XCTAssert(app.staticTexts["Data Collected"].exists)
              XCTAssert(app.staticTexts["The weather data has been successfuly collected"].exists)
              XCTAssert(app.staticTexts["View Results"].exists)

              app.buttons["View Results"].tap()
        //
              XCTAssert(app.staticTexts["Weather"].exists)
              XCTAssert(app.staticTexts["broken clouds"].exists)

              XCTAssert(app.staticTexts["Temperature"].exists)
        //      XCTAssert(app.staticTexts["27.90 C"].exists)

              app.buttons["Done"].tap()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
