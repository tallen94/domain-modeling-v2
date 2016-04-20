//
//  CustomStringTest.swift
//  SimpleDomainModel
//
//  Created by Trevor Allen on 4/19/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import XCTest

class CustomStringTest: XCTestCase {

    func testMoneyString() {
        let money1: Double = 21.0
        let money2: Double = 22.0
        
        XCTAssert(money1.USD.description == "USD 21.0")
        XCTAssert(money2.EUR.description == "EUR 22.0")
    }
    
    func testJobString() {
        let job1: Job = Job(title: "Software Dev", type: Job.JobType.Hourly(27))
        XCTAssert(job1.description == "Software Dev Hourly(27.0)")
    }

    func testPersonString() {
        let person: Person = Person(firstName: "Trevor", lastName: "Allen", age: 21)
        
        XCTAssert(person.description == "[Person: firstName:Trevor lastName:Allen age:21 job:nil spouse:nil]")
    }
}
