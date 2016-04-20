//
//  MathProtocolTest.swift
//  SimpleDomainModel
//
//  Created by Trevor Allen on 4/19/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import XCTest

class MathProtocolTest: XCTestCase {

    func testAdd() {
        let USD1: Money = Money(amount: 21.0, currency: "USD")
        let USD2: Money = Money(amount: 10.3, currency: "USD")
        
        let sum: Money = USD1.add(USD2)
        
        XCTAssert(sum.amount == 31.3)
        XCTAssert(sum.currency == "USD")
    }
    
    func testSubtract() {
        let USD1: Money = Money(amount: 10, currency: "USD")
        let USD2: Money = Money(amount: 20, currency: "USD")
        
        let sum = USD1.subtract(USD2)
        
        XCTAssert(sum.amount == 10)
        XCTAssert(sum.currency == "USD")
    }
}
