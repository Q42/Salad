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
    return waitForCondition(timeout: timeout) { self.exists }
  }

  func waitForExistsAndHittable(timeout: TimeOut) -> Bool {
    return waitForCondition(timeout: timeout) { self.exists && self.isHittable }
  }

  func waitForNotExists(timeout: TimeOut) -> Bool {
    return waitForCondition(timeout: timeout) { !self.exists }
  }

  func waitForValueNotNill(timeout: TimeOut) -> Bool {
    return waitForCondition(timeout: timeout) { self.value != nil }
  }

  func waitForValue(timeout: TimeOut, value: String) -> Bool {
    return waitForCondition(timeout: timeout) { self.label == value }
  }

  private func waitForCondition(timeout: TimeOut, conditionToCheck: @escaping () -> Bool) -> Bool {
    let expectation = XCTestExpectation()

    for _ in 0...timeout.numberOfPolls {
      if conditionToCheck() {
        expectation.fulfill()
      }

      let result = XCTWaiter.wait(for: [expectation], timeout: timeout.timeInterval)

      if case .completed = result {
        return true
      }
    }

    return false
  }
}
