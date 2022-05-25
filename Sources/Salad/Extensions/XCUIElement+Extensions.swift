//
//  XCUIElement+Extensions.swift
//  Salad
//
//  Created by Mathijs Bernson on 24/01/2020.
//

import Foundation
import XCTest

public extension XCUIElement {
  /// Waits the amount of time you specify for the element’s `exists` property to become true.
  /// - Returns: false if the timeout expires without the element coming into existence.
  func waitForExist(timeout: TimeOut) -> Bool {
    if exists { return true }
    return waitForExistence(timeout: timeout.timeInterval)
  }

  /// Waits the amount of time you specify for the element’s `exists` and `isHittable` properties to become true.
  func waitForExistsAndHittable(timeout: TimeOut) -> Bool {
    if exists && isHittable { return true }
    return waitForPredicate(NSPredicate(format: "exists == true && hittable == true"), timeout: timeout)
  }

  /// Waits the amount of time you specify for the element’s `exists` property to become false.
  func waitForNotExists(timeout: TimeOut) -> Bool {
    if !exists { return true }
    return waitForPredicate(NSPredicate(format: "exists == false"), timeout: timeout)
  }

  /// Waits the amount of time you specify for the element’s `label` property to become the specified value.
  func waitForLabel(toBecome value: String, timeout: TimeOut) -> Bool {
    if label == value { return true }
    return waitForPredicate(NSPredicate(format: "label == %@", value), timeout: timeout)
  }

  /// Waits the amount of time you specify for the given predicate to become true.
  private func waitForPredicate(_ predicate: NSPredicate, timeout: TimeOut) -> Bool {
    if case .instant = timeout { return false }

    let expectation = XCTNSPredicateExpectation(predicate: predicate, object: self)
    return XCTWaiter.wait(for: [expectation], timeout: timeout.timeInterval) == .completed
  }
}
