//
//  Copyright © Dyson 2021
//

import XCTest

class ConnectivityRemoteTestUITests: ConnectivtyRemoteTestBase {
    
    
    /*Scenario: Chekc for internet connectivity with Wi-Fi on
     Given User has enabled internet connection
     When User launch the app
     Then Check internet connectivty Message You are connected to Internet
     AND Check the status to be Connected
     AND Fetch Data button should be visisble
     */
    func test_verify_check_for_internet_connectivity_with_internet() throws{
        let alphaPage = alphaPage(app: app)
        XCTAssert(alphaPage.connectedText.exists)
        XCTAssert(alphaPage.connectivityPageTitle.exists)
        XCTAssert(alphaPage.connectToInternet.exists)
        XCTAssert(alphaPage.tickMarkIcon.exists)
        XCTAssert(alphaPage.fetchDataButton.exists)
        XCTAssert(alphaPage.fetchDataText.exists)
    }
    

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
    
    /*"Sceanrio: Verify that tapping the 'View Results' button twice does not alter the displayed weather data."
     Given User is connected to Internet
     When I Lauch the APP and Tap on FetchData
     When I tap on View Results
     Then Weather information is displayed
     AND Temperature data is displayed
     When User taps on Back button
     When User taps on View Results
     Then check same weather and temperature data is displayed
     
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
    
    
    /* Given you have installed the app
     When you open the app
     Then Meassure the time taken to launch the app should be less than or equal to 2seconds
     AND Repeate the Cycle for 5 iteration
     */
    func test_Launch_Performance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    /* Given you have installed the app
     When you open the app
     Then Meassure the memeory consumed should be less than 90kb
     AND Repeate the Cycle for 5 iteration
     */
    
    func test_Memeory_Performance() throws{
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {

                   measure(metrics: [XCTMemoryMetric()]) {
                       XCUIApplication().launch()
                   }
               }
    }
}
