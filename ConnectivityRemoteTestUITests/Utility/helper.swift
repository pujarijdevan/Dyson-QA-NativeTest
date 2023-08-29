//
//  Copyright © Dyson 2023
//

import Foundation
import XCTest

class TestUtilities {
    static func waitForElementToAppear(_ element: XCUIElement, timeout: TimeInterval = 10) {
            let expectation = XCTNSPredicateExpectation(predicate: NSPredicate(format: "exists == true"), object: element)
            let result = XCTWaiter.wait(for: [expectation], timeout: timeout)
            
            if result != .completed {
                XCTFail("Element did not appear within the specified timeout")
            }
        }
    static func validateTemperatureFormat(_ temperature: String) -> Bool {
            let temperatureRegex = "\\d+\\.\\d+°C"
            let temperatureRegexPredicate = NSPredicate(format: "SELF MATCHES %@", temperatureRegex)
            return temperatureRegexPredicate.evaluate(with: temperature)
        }
}

