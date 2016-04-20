//
//  DoubleExtensionTests.swift
//  SimpleDomainModel
//
//  Created by Trevor Allen on 4/19/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import XCTest

class DoubleExtensionTests: XCTestCase {

    func testExtension() {
        let x: Double = 30
        let y: Double = 21
        
        let money1: Money = x.USD
        let money2: Money = y.EUR
        
        XCTAssert(money1.amount == 30)
        XCTAssert(money1.currency == "USD")
        
        XCTAssert(money2.amount == 21)
        XCTAssert(money2.currency == "EUR")
    }
}
