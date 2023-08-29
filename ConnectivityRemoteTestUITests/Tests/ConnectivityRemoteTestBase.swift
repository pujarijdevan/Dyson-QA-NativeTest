//
//  Copyright © Dyson 2023
//

import Foundation
import XCTest

class ConnectivtyRemoteTestBase: XCTestCase{
    
    var app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launch()
        
    }
    
    override func tearDown() {
        super.tearDown()
    }
}
