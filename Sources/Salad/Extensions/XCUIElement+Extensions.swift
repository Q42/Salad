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
    return waitThenCheck(timeout: timeout) { self.exists }
  }

  func waitForExistsAndHittable(timeout: TimeOut) -> Bool {
    return waitThenCheck(timeout: timeout) { self.exists && self.isHittable }
  }

  func waitForNotExists(timeout: TimeOut) -> Bool {
    return waitThenCheck(timeout: timeout) { !self.exists }
  }

  func waitForValueNotNill(timeout: TimeOut) -> Bool {
    return waitThenCheck(timeout: timeout) { self.value != nil }
  }

  func waitForValue(timeout: TimeOut, value: String) -> Bool {
    return waitThenCheck(timeout: timeout) { self.label == value }
  }

  private func waitThenCheck(timeout: TimeOut, conditionToCheck: @escaping () -> Bool) -> Bool {
    // We can't reach the XCTestCase that were currently inside of, so just create a new one instead.
    let testCase = XCTestCase()

    for _ in 0...timeout.numberOfPolls {
      testCase.expectation(for: NSPredicate(block: { _, _ in conditionToCheck() }), evaluatedWith: self, handler: nil)
      testCase.waitForExpectations(timeout: timeout.timeInterval, handler: nil)

      if conditionToCheck() {
        return true
      }
    }

    return false
  }
}
