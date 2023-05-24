//
//  ViewObject.swift
//  Salad
//
//  Created by PQTE on 05/04/2019.
//  Copyright © 2019 Q42. All rights reserved.
//

import Foundation
import XCTest

/// A structure in your test that corresponds to a view in your app, identified by its accessibility identifier.
public protocol ViewObject {
  /// The root element in which this view is located.
  var root: XCUIElement { get }

  /// The accessibility identifier unique to this view within the scope of the root element.
  ///
  /// This element will be checked for existence when this `ViewObject` is created using `createVerifiedViewObject`.
  var identifyingElementId: String { get }

  /// Creates an instance of the view given a root view.
  init(root: XCUIElement)
}

public extension ViewObject {
  /// The unique element representing this view within the scope of the root element.
  var identifyingElement: XCUIElement {
    root.descendants(matching: .any).matching(identifier: identifyingElementId).firstMatch
  }

  /// Assert that this view exists within its root element, within the given time out.
  func assertIdentifyingElementExists(timeout: TimeOut, file: StaticString = #file, line: UInt = #line) {
    XCTAssertTrue(identifyingElement.waitForExist(timeout: timeout), "Expected to be on view object '\(Self.self)', but identifying element '\(identifyingElementId)' does not exist. (Did wait for \(timeout.timeInterval) seconds)", file: file, line: line)
  }
}
