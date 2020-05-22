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
    let waiter = XCTWaiter()
    let expectation = XCTestExpectation()

    for _ in 0...timeout.numberOfPolls {
      if conditionToCheck() {
        expectation.fulfill()
      }

      let result = waiter.wait(for: [expectation], timeout: timeout.timeInterval)

      if case .completed = result {
        return true
      }
    }

    return false
  }
}
