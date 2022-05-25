//
//  XCUIElementQuery+Extensions.swift
//  Salad
//
//  Created by Sander de Vos on 02/07/2020.
//

import Foundation
import XCTest

public extension XCUIElementQuery {
  /// Waits the amount of time you specify for the element’s `count` property to become the specified value.
  func waitForCount(toBecome value: Int, timeout: TimeOut) -> Bool {
    waitForPredicate(NSPredicate(format: "count == %i", value), timeout: timeout)
  }

  /// Waits the amount of time you specify for the given predicate to become satisfied.
  private func waitForPredicate(_ predicate: NSPredicate, timeout: TimeOut) -> Bool {
    let expectation = XCTNSPredicateExpectation(predicate: predicate, object: self)
    return XCTWaiter.wait(for: [expectation], timeout: timeout.timeInterval) == .completed
  }
}
