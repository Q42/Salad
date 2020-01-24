//
//  XCUIElement+ViewObject.swift
//  Salad
//
//  Created by Mathijs Bernson on 24/01/2020.
//

import Foundation
import XCTest

extension XCUIElement {
  /// Creates the requested `ViewObject` and verifies the `identifyingElement` of that object exists.
  ///
  /// - Note: An `XCTest` assertion will fail when the `identifyingElement` is missing.
  ///
  /// - Parameters:
  ///     - root: Element from where to look for the `identifyingElement`
  ///     - timeout: Maximum duration that the `identifyingElement` might take to rootear on screen
  ///     - file: File that will be passed on to the assertion
  ///     - line: Line that will be passed on to the assertion
  /// - Returns: Instance of the requested `ViewObject`
  public func createVerifiedViewObject<TargetViewObject: ViewObject>(root: XCUIElement, timeout: TimeOut = .asyncUI, file: StaticString = #file, line: UInt = #line) -> TargetViewObject {
    let viewObject = TargetViewObject(root: root)

    viewObject.assertIdentifyingElementExists(timeout: timeout, file: file, line: line)

    return viewObject
  }

  /// Creates the requested `ViewObject` and verifies the `identifyingElement` of that object exists.
  ///
  /// - Note: An `XCTest` assertion will fail when the `identifyingElement` is missing.
  ///
  /// - Parameters:
  ///     - timeout: Maximum duration that the `identifyingElement` might take to rootear on screen
  ///     - file: File that will be passed on to the assertion
  ///     - line: Line that will be passed on to the assertion
  /// - Returns: Instance of the requested `ViewObject`
  public func createVerifiedViewObject<TargetViewObject: ViewObject>(timeout: TimeOut = .asyncUI, file: StaticString = #file, line: UInt = #line) -> TargetViewObject {
    createVerifiedViewObject(root: self, timeout: timeout, file: file, line: line)
  }
}
