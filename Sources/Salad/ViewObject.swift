//
//  ViewObject.swift
//  Salad
//
//  Created by PQTE on 05/04/2019.
//  Copyright © 2019 Q42. All rights reserved.
//

import Foundation
import XCTest

public protocol ViewObject {
  var root: XCUIElement { get }

  /// Element that will be checked for existence when this `ViewObject` is created using `createVerifiedViewObject`
  var identifyingElementId: String { get }

  init(root: XCUIElement)
}

public extension ViewObject {
  var identifyingElement: XCUIElement {
    element(identifyingElementId)
  }

  /// Searches the root element in its current state for an unique child element with the given accessibility identifier.
  ///
  /// - Note: An `XCTest` assertion will fail when the `identifier` is missing or when there are multiple matches.
  ///
  /// - Parameter identifier: The accessibility identifier to look up
  /// - Returns: `XCUIElement` found using the given identifier
  func element(_ identifier: String) -> XCUIElement {
    root.descendants(matching: .any).matching(identifier: identifier).element
  }

  func assertIdentifyingElementExists(timeout: TimeOut, file: StaticString = #file, line: UInt = #line) {
    let elementToAssert = element(identifyingElementId)
    XCTAssertTrue(elementToAssert.waitForExist(timeout: timeout), "Expected to be on view object '\(Self.self)', but identifying element '\(identifyingElementId)' does not exist. (Did wait for \(timeout.timeInterval) seconds)", file: file, line: line)
  }
}
