//
//  Behaviour.swift
//  Salad
//
//  Created by Mathijs Kadijk on 23/07/2019.
//  Copyright © 2019 Q42. All rights reserved.
//

import Foundation

/// A structure that performs an interaction on a view. The interaction may transition it to a different view.
public protocol Behaviour {
  /// The type of view that this behaviour is performed on.
  associatedtype FromView: ViewObject

  /// The type of view that is on screen after the behaviour has been performed. It may be the same type as `FromView`.
  associatedtype ToView: ViewObject

  /// Perform the behaviour on the app, transitioning it from the `FromView` to the `ToView`.
  func perform(from view: FromView) -> ToView
}

public extension Behaviour {
  /// Combine two behaviours into a single behaviour.
  func chain<NextBehaviour>(_ behaviour: NextBehaviour) -> ChainedBehaviour<Self, NextBehaviour> {
    ChainedBehaviour(firstBehaviour: self, secondBehaviour: behaviour)
  }
}

/// A combination of two behaviours.
public struct ChainedBehaviour<FirstBehaviour: Behaviour, SecondBehaviour: Behaviour>: Behaviour where FirstBehaviour.ToView == SecondBehaviour.FromView {
  private let firstBehaviour: FirstBehaviour
  private let secondBehaviour: SecondBehaviour

  init(firstBehaviour: FirstBehaviour, secondBehaviour: SecondBehaviour) {
    self.firstBehaviour = firstBehaviour
    self.secondBehaviour = secondBehaviour
  }

  public func perform(from view: FirstBehaviour.FromView) -> SecondBehaviour.ToView {
    let intermediateView = firstBehaviour.perform(from: view)
    return secondBehaviour.perform(from: intermediateView)
  }
}
