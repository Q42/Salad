//
//  Scenario.swift
//  Salad
//
//  Created by Mathijs Bernson on 24/01/2020.
//  Copyright © 2020 Q42. All rights reserved.
//

import Foundation
import XCTest

public struct Scenario<FromView: ViewObject> {
  private let view: FromView

  public init(given root: XCUIElement) {
    view = root.createVerifiedViewObject()
  }

  private init(given view: FromView) {
    self.view = view
  }

  public func when<B: Behaviour>(_ behaviour: B) throws -> Scenario<B.ToView> where B.FromView == FromView {
    return try XCTContext.runActivity(named: String(describing: B.self)) { activity in
      Scenario<B.ToView>(given: try behaviour.perform(from: view))
    }
  }

  public func when<ToView: ViewObject>(_ behaviourBlock: (FromView) throws -> ToView) rethrows -> Scenario<ToView> {
    return Scenario<ToView>(given: try behaviourBlock(view))
  }

  @discardableResult
  public func then(_ thenBlock: (FromView) -> Void) throws -> Scenario<FromView> {
    thenBlock(view)
    return self
  }
}
