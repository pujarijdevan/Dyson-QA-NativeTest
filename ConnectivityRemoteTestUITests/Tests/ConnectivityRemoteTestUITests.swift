//
//  Copyright © Dyson 2021
//

import XCTest

class ConnectivityRemoteTestUITests: ConnectivtyRemoteTestBase {

    /*Scenario: Get the high level weather forecast
     Given I have an internet connection
     When I have successfully downloaded the weather data
     Then I can see the weather and temperature for today
     */
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
        let Temperature = weatherDisplayScreen.getTemperatureValue()
        XCTAssert(TestUtilities.validateTemperatureFormat(Temperature), "Temperature format does not match expected pattern")
        XCTAssert(weatherDisplayScreen.weatherIcon.exists)
        XCTAssert(weatherDisplayScreen.weatherDescriptionLabel.exists)
        XCTAssert(weatherDisplayScreen.titleWeather.exists)
        XCTAssert(weatherDisplayScreen.tempratureIcon.exists)
        XCTAssert(weatherDisplayScreen.temperatureDescription.exists)
        XCTAssert(weatherDisplayScreen.doneButton.exists)
        weatherDisplayScreen.doneButton.tap()
        weatherDisplayScreen.dismissFinishedAlert()
    }
    
    
    /* Sceanrio : Verify connectivity screen without internet
     Given User is Not connected to internet
     When User launch the app
     Then An internet connection cannot be made message is displayed
     */
    func test_verify_connectivitypage_without_internet(){
        let alphaPage = alphaPage(app: app)
        XCTAssert(alphaPage.noInternetConnectionMessage.exists)
        XCTAssert(alphaPage.unableToConnectText.exists)
    }
    
    /*"Verify that tapping the 'View Results' button twice does not alter the displayed weather data."
     */
    func test_verify_tapping_viewResults_twice_doesnot_alter_weatherdata(){
        let alphaPage = alphaPage(app: app)
        XCTAssert(alphaPage.connectivityPageTitle.exists)
        alphaPage.fetchDataButton.tap()
        let dataCollectionScreen = dataCollectionScreen(app: app)
        TestUtilities.waitForElementToAppear(dataCollectionScreen.dataCollectionSuccessStatus)
        dataCollectionScreen.viewResultsButton.tap()
        let weatherDisplayScreen = weatherScreen(app: app)
        TestUtilities.waitForElementToAppear(weatherDisplayScreen.temperatureDescription)
        let initialTemperature = weatherDisplayScreen.getTemperatureValue()
        let initialWeather = weatherDisplayScreen.getweatherValue()
        XCTAssert(TestUtilities.validateTemperatureFormat(initialTemperature), "Temperature format does not match expected pattern")
        weatherDisplayScreen.tapDataCollectionButton()
        TestUtilities.waitForElementToAppear(dataCollectionScreen.dataCollectionSuccessStatus)
        dataCollectionScreen.viewResultsButton.tap()
        TestUtilities.waitForElementToAppear(weatherDisplayScreen.temperatureDescription)
        let finalTemperature = weatherDisplayScreen.getTemperatureValue()
        let finalWeather = weatherDisplayScreen.getweatherValue()
        print(finalTemperature)
        print(finalWeather)
        XCTAssertEqual(initialTemperature, finalTemperature, "Temperature description changed after reloading")
        XCTAssertEqual(initialWeather, finalWeather, "Weather desscription changed after reloading")
                
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
