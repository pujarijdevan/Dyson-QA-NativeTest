//
//  Copyright © Dyson 2023
//

import Foundation
import XCTest

class dataCollectionScreen{
    
    private let app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    var dataCollectionSuccessStatus: XCUIElement {
            return app.staticTexts["Data Collected"]
        }
    
    var dataCollectionPageTitle: XCUIElement {
    return app.navigationBars["Data Collection"].staticTexts["Data Collection"]
    }
    
    var dataCollectionSuccessMessage: XCUIElement {
            return app.staticTexts["The weather data has been successfuly collected"]
        }
    
    
        
    var viewResultsButton: XCUIElement {
            return app.buttons["View Results"]
        }
    
    var sucessIcon: XCUIElement {
        return app/*@START_MENU_TOKEN@*/.images["view_results_icon_image"]/*[[".otherElements[\"bravo_screen\"].images[\"view_results_icon_image\"]",".images[\"view_results_icon_image\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
    }
        
    
    
}
