//
//  Scenario.swift
//  Salad
//
//  Created by Mathijs Bernson on 24/01/2020.
//  Copyright © 2020 Q42. All rights reserved.
//

import Foundation
import XCTest

/// A structure that applies behaviors to views.
public struct Scenario<FromView: ViewObject> {
  private let view: FromView

  public init(given root: XCUIElement) {
    view = root.createVerifiedViewObject()
  }

  private init(given view: FromView) {
    self.view = view
  }

  public func when<B: Behavior>(_ behavior: B) -> Scenario<B.ToView> where B.FromView == FromView {
    return XCTContext.runActivity(named: String(describing: B.self)) { activity in
      Scenario<B.ToView>(given: behavior.perform(from: view))
    }
  }

  public func when<ToView: ViewObject>(_ behaviorBlock: (FromView) -> ToView) -> Scenario<ToView> {
    return Scenario<ToView>(given: behaviorBlock(view))
  }

  public func when<ToView: ViewObject>(_ behaviorBlock: (FromView) throws -> ToView) rethrows -> Scenario<ToView> {
    return Scenario<ToView>(given: try behaviorBlock(view))
  }

  @discardableResult
  public func then(_ thenBlock: (FromView) -> Void) -> Scenario<FromView> {
    thenBlock(view)
    return self
  }

  @discardableResult
  public func then(_ thenBlock: (FromView) throws -> Void) rethrows -> Scenario<FromView> {
    try thenBlock(view)
    return self
  }
}
