//
//  Behavior.swift
//  Salad
//
//  Created by Mathijs Kadijk on 23/07/2019.
//  Copyright © 2019 Q42. All rights reserved.
//

import Foundation

/// A structure that performs an interaction on a view. The interaction may transition it to a different view.
public protocol Behavior {
  /// The type of view that this behavior is performed on.
  associatedtype FromView: ViewObject

  /// The type of view that is on screen after the behavior has been performed. It may be the same type as `FromView`.
  associatedtype ToView: ViewObject

  /// Perform the behavior on the app, transitioning it from the `FromView` to the `ToView`.
  func perform(from view: FromView) -> ToView
}

public extension Behavior {
  /// Combine two behaviors into a single behavior.
  func chain<NextBehavior>(_ behavior: NextBehavior) -> ChainedBehavior<Self, NextBehavior> {
    ChainedBehavior(firstBehavior: self, secondBehavior: behavior)
  }
}

/// A combination of two behaviors.
public struct ChainedBehavior<FirstBehavior: Behavior, SecondBehavior: Behavior>: Behavior where FirstBehavior.ToView == SecondBehavior.FromView {
  private let firstBehavior: FirstBehavior
  private let secondBehavior: SecondBehavior

  init(firstBehavior: FirstBehavior, secondBehavior: SecondBehavior) {
    self.firstBehavior = firstBehavior
    self.secondBehavior = secondBehavior
  }

  public func perform(from view: FirstBehavior.FromView) -> SecondBehavior.ToView {
    let intermediateView = firstBehavior.perform(from: view)
    return secondBehavior.perform(from: intermediateView)
  }
}
