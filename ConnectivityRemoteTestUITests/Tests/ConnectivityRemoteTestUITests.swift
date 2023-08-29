//
//  Copyright © Dyson 2021
//

import XCTest

class ConnectivityRemoteTestUITests: ConnectivtyRemoteTestBase {


    func test_verify_todays_weather() throws {
        
        let alphaPage = alphaPage(app: app)
        XCTAssert(alphaPage.connectedText.exists)
        XCTAssert(alphaPage.connectivityPageTitle.exists)
        XCTAssert(alphaPage.connectToInternet.exists)
        XCTAssert(alphaPage.tickMarkIcon.exists)
        XCTAssert(alphaPage.fetchDataButton.exists)
        XCTAssert(alphaPage.fetchDataText.exists)
        alphaPage.fetchDataButton.tap()
        let dataCollectionScreen = dataCollectionScreen(app: app)
        TestUtilities.waitForElementToAppear(dataCollectionScreen.dataCollectionSuccessStatus)
        XCTAssert(dataCollectionScreen.dataCollectionPageTitle.exists)
        XCTAssert(dataCollectionScreen.dataCollectionSuccessMessage.exists)
        XCTAssert(dataCollectionScreen.sucessIcon.exists)
        XCTAssert(dataCollectionScreen.viewResultsButton.exists)
        dataCollectionScreen.viewResultsButton.tap()
        let weatherDisplayScreen = weatherScreen(app: app)
        TestUtilities.waitForElementToAppear(weatherDisplayScreen.temperatureDescription)
        XCTAssert(weatherDisplayScreen.weatherIcon.exists)
        XCTAssert(weatherDisplayScreen.weatherDescriptionLabel.exists)
        XCTAssert(weatherDisplayScreen.titleWeather.exists)
        XCTAssert(weatherDisplayScreen.tempratureIcon.exists)
        XCTAssert(weatherDisplayScreen.temperatureDescription.exists)
        XCTAssert(weatherDisplayScreen.doneButton.exists)
        weatherDisplayScreen.doneButton.tap()
        weatherDisplayScreen.dismissFinishedAlert()
    }
    
        
    
    func testsample(){
        let app = XCUIApplication()
        app.launch()
        app.staticTexts["connectivity_title_label"].tap()
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
