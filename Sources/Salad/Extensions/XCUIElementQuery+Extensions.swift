//
//  XCUIElementQuery+Extensions.swift
//  Salad
//
//  Created by Sander de Vos on 02/07/2020.
//

import Foundation
import XCTest

public extension XCUIElementQuery {

  func waitForCount(timeout: TimeOut, count: Int) -> Bool {
    waitForPredicate(NSPredicate(format: "count == %@", count), timeout: timeout)
  }

  private func waitForPredicate(_ predicate: NSPredicate, timeout: TimeOut) -> Bool {
    let expectation = XCTNSPredicateExpectation(predicate: predicate, object: self)
    return XCTWaiter.wait(for: [expectation], timeout: timeout.timeInterval) == .completed
  }
}
