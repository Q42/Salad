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
    waitForExistence(timeout: timeout.timeInterval)
  }

  func waitForExistsAndHittable(timeout: TimeOut) -> Bool {
    waitForPredicate(NSPredicate(format: "exists == true && hittable == true"), timeout: timeout)
  }

  func waitForNotExists(timeout: TimeOut) -> Bool {
    waitForPredicate(NSPredicate(format: "exists == false"), timeout: timeout)
  }

  func waitForLabelNotNill(timeout: TimeOut) -> Bool {
    waitForPredicate(NSPredicate(format: "label != nil"), timeout: timeout)
  }

  func waitForLabel(toBecome value: String, timeout: TimeOut) -> Bool {
    waitForPredicate(NSPredicate(format: "label == %@", value), timeout: timeout)
  }

  private func waitForPredicate(_ predicate: NSPredicate, timeout: TimeOut) -> Bool {
    let expectation = XCTNSPredicateExpectation(predicate: predicate, object: self)
    return XCTWaiter.wait(for: [expectation], timeout: timeout.timeInterval) == .completed
  }
}
