//
//  Copyright © Dyson 2023
//

import Foundation
import XCTest

class weatherScreen{
    private let app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    var titleWeather: XCUIElement {
            return app.staticTexts["Weather"]
        }
        
        var weatherDescriptionLabel: XCUIElement {
            return app.staticTexts["weather_description_label"]
        }
        
        var temperatureLabel: XCUIElement {
            return app.staticTexts["Temperature"]
        }
        
        var temperatureDescription: XCUIElement {
        return app.staticTexts["temperature_description_label"]
        }
    
       var weatherIcon: XCUIElement {
        return app.images["weather_icon"]
       }
    
        var tempratureIcon: XCUIElement {
        return app.images["temperature_icon"]
        }
    
    
        var doneButton: XCUIElement {
            return app.buttons["Done"]
        }
    
        var weatherDisplayPageTitle: XCUIElement {
            return app.navigationBars["Weather Data"].staticTexts["Weather Data"]
        }
    
        func dismissFinishedAlert() {
        let finishedAlert = app.alerts["Finished"]
        
        if finishedAlert.waitForExistence(timeout: 10) {
            finishedAlert.scrollViews.otherElements.buttons["Dismiss"].tap()
        } else {
            XCTFail("Finished alert did not appear within the specified timeout")
        }
    }
}

