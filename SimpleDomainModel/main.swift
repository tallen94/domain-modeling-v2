//
//  main.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import Foundation

public func testMe() -> String {
  return "I have been tested"
}

public class TestMe {
  public func Please() -> String {
    return "I have been tested"
  }
}

////////////////////////////////////
// Money
//
public struct Money: CustomStringConvertible, Mathematics {
    
    public var description: String {
        get {return "\(self.currency) \(self.amount)"}
    }
    
    public var amount : Double
    public var currency : String
    private var exchanges : Dictionary<String, Double> = [
        "USD" : 1.0,
        "GBP" : 0.5,
        "EUR" : 1.5,
        "CAN" : 1.25
    ]
    
    public init(amount: Double, currency: String) {
        self.amount = amount;
        self.currency = currency;
    }
  
    public func convert(to: String) -> Money {
        let newAmt = (Double(self.amount) / exchanges[self.currency]!) * exchanges[to]!
        let newMoney = Money(amount: newAmt, currency: to)
        return newMoney;
    }
  
    public func add(to: Money) -> Money {
        var newMoney : Money
        if self.currency != to.currency {
            let temp = self.convert(to.currency)
            newMoney = Money(amount: temp.amount + to.amount, currency: to.currency)
        } else {
            newMoney = Money(amount: self.amount + to.amount, currency: to.currency)
        }
        return newMoney
    }
    
    public func subtract(from: Money) -> Money {
        var newMoney : Money
        if self.currency != from.currency {
            let temp = self.convert(from.currency)
            newMoney = Money(amount: from.amount - temp.amount, currency: from.currency)
        } else {
            newMoney = Money(amount: from.amount - self.amount, currency: from.currency)
        }
        return newMoney
    }
}

////////////////////////////////////
// Job
//
public class Job: CustomStringConvertible {
    
    public var description: String {
        get { return "\(self.title) \(self.type)" }
    }
    
    public var title : String
    public var type : JobType
    public enum JobType {
        case Hourly(Double)
        case Salary(Int)
    }
  
    public init(title : String, type : JobType) {
        self.title = title
        self.type = type
    }
  
    public func calculateIncome(hours: Int) -> Int {
        switch self.type {
        case .Hourly (let value):
            let income = value * Double(hours)
            return Int(income)
        case .Salary (let value):
            return value
        }
    }
  
    public func raise(amt : Double) {
        switch self.type {
        case .Hourly (let value):
            self.type = JobType.Hourly(value + amt)
            break
        case .Salary (let value):
            let raise = value + Int(amt)
            self.type = JobType.Salary(raise)
            break
        }
    }
}


////////////////////////////////////
// Person
//
public class Person: CustomStringConvertible {
    
    public var description: String {
        get { return "[Person: firstName:\(self.firstName) lastName:\(self.lastName) age:\(self.age) job:\(self.job) spouse:\(self.spouse)]" }
    }
    
    public var firstName : String = ""
    public var lastName : String = ""
    public var age : Int = 0
    public var _job : Job?
    public var _spouse : Person?

    public var job : Job? {
        get { return _job }
        set(value) {
            if self.age >= 16 {
                _job = value
            }
        }
    }

    public var spouse : Person? {
        get { return _spouse }
        set(value) {
            if self.age >= 18 {
                _spouse = value
            }
        }
    }

    public init(firstName : String, lastName: String, age : Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }

    public func toString() -> String {
        return "[Person: firstName:\(self.firstName) lastName:\(self.lastName) age:\(self.age) job:\(self.job) spouse:\(self.spouse)]"
    }
}

////////////////////////////////////
// Family
//
public class Family: CustomStringConvertible {
    
    public var description: String {
        get { return "\(self.members)" }
    }
    
    private var members : [Person] = []

    public init(spouse1: Person, spouse2: Person) {
        if spouse1.spouse == nil && spouse2.spouse == nil {
            spouse1.spouse = spouse2
            spouse2.spouse = spouse1
        }
        members.append(spouse1)
        members.append(spouse2)
    }

    public func haveChild(child: Person) -> Bool {
        for person in members {
            if person.age >= 21 {
                members.append(child)
                return true
            }
        }
        return false
    }

    public func householdIncome() -> Int {
        var income : Int = 0
        for person in members {
            if person.job != nil {
                income += person.job!.calculateIncome(2000)
            }
        }
        return income
    }
}

////////////////////////////////////
// Mathematics
//
protocol Mathematics {
    func add(to: Self) -> Self
    func subtract(from: Self) -> Self
}

extension Double {
    public var USD: Money {
        get { return Money(amount: self, currency: "USD") }
    }
    
    public var EUR: Money {
        get { return Money(amount: self, currency: "EUR") }
    }
    
    public var GBP: Money {
        get { return Money(amount: self, currency: "GBP") }
    }
    
    public var YEN: Money {
        get { return Money(amount: self, currency: "YEN") }
    }
}

