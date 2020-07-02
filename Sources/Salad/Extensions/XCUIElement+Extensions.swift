//
//  XCUIElement+Extensions.swift
//  Salad
//
//  Created by Mathijs Bernson on 24/01/2020.
//

import Foundation
import XCTest

public extension XCUIElement {
  func waitForExist(timeout: TimeOut) -> Bool {
    if exists { return true }
    return waitForExistence(timeout: timeout.timeInterval)
  }

  func waitForExistsAndHittable(timeout: TimeOut) -> Bool {
    if exists && isHittable { return true }
    return waitForPredicate(NSPredicate(format: "exists == true && hittable == true"), timeout: timeout)
  }

  func waitForNotExists(timeout: TimeOut) -> Bool {
    if !exists { return true }
    return waitForPredicate(NSPredicate(format: "exists == false"), timeout: timeout)
  }

  func waitForLabel(toBecome value: String, timeout: TimeOut) -> Bool {
    if label == value { return true }
    return waitForPredicate(NSPredicate(format: "label == %@", value), timeout: timeout)
  }

  private func waitForPredicate(_ predicate: NSPredicate, timeout: TimeOut) -> Bool {
    if case .instant = timeout { return false }

    let expectation = XCTNSPredicateExpectation(predicate: predicate, object: self)
    return XCTWaiter.wait(for: [expectation], timeout: timeout.timeInterval) == .completed
  }
}
