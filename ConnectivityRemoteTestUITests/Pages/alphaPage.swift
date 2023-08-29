//
//  Copyright © Dyson 2023
//

import Foundation
import XCTest

class alphaPage{
    
    private let app: XCUIApplication

        init(app: XCUIApplication) {
            self.app = app
        }

        var connectedText: XCUIElement {
            return app.staticTexts["Connected"]
        }
        
        var unableToConnectText: XCUIElement {
            return app.staticTexts["Unable To Connect"]
        }
    
        var noInternetConnectionMessage: XCUIElement {
            return app.staticTexts["An internet connection cannot be made"]
        }

        var connectToInternet: XCUIElement {
            return app.staticTexts["You are connected to the internet"]
        }

        var tickMarkIcon: XCUIElement {
            return app.images["icon_image"]
        }

        var fetchDataButton: XCUIElement {
            return app.buttons["Fetch Data"]
        }
        
    var fetchDataText: XCUIElement {
        return app.staticTexts["Fetch Data"]
        
        }
    
    var connectivityPageTitle: XCUIElement {
    return app.navigationBars["Connectivity"].staticTexts["Connectivity"]
    }
    
    

}
    

