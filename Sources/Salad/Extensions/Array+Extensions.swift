//
//  Array+Extensions.swift
//  
//
//  Created by Mathijs Bernson on 25/04/2023.
//

import Foundation
import XCTest

public extension Array {
  func waitForCount(toBecome expectedCount: Int, timeout: TimeOut) -> Bool {
    if count == expectedCount { return true }
    return waitForPredicate(NSPredicate(format: "@count == %d", expectedCount), timeout: timeout)
  }

  private func waitForPredicate(_ predicate: NSPredicate, timeout: TimeOut) -> Bool {
    let expectation = XCTNSPredicateExpectation(predicate: predicate, object: self)
    return XCTWaiter.wait(for: [expectation], timeout: timeout.timeInterval) == .completed
  }
}
