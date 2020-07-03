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
    root.descendants(matching: .any).matching(identifier: identifyingElementId).firstMatch
  }

  func assertIdentifyingElementExists(timeout: TimeOut, file: StaticString = #file, line: UInt = #line) {
    XCTAssertTrue(identifyingElement.waitForExist(timeout: timeout), "Expected to be on view object '\(Self.self)', but identifying element '\(identifyingElementId)' does not exist. (Did wait for \(timeout.timeInterval) seconds)", file: file, line: line)
  }
}
