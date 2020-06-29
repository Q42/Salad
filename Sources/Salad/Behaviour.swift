//
//  Behaviour.swift
//  Salad
//
//  Created by Mathijs Kadijk on 23/07/2019.
//  Copyright © 2019 Q42. All rights reserved.
//

import Foundation

public protocol Behaviour {
  associatedtype FromView: ViewObject
  associatedtype ToView: ViewObject

  func perform(from view: FromView) throws -> ToView
}

public extension Behaviour {
  func chain<NextBehaviour>(_ behaviour: NextBehaviour) -> ChainedBehaviour<Self, NextBehaviour> {
    ChainedBehaviour(firstBehaviour: self, secondBehaviour: behaviour)
  }
}

public struct ChainedBehaviour<FirstBehaviour: Behaviour, SecondBehaviour: Behaviour>: Behaviour where FirstBehaviour.ToView == SecondBehaviour.FromView {
  private let firstBehaviour: FirstBehaviour
  private let secondBehaviour: SecondBehaviour

  init(firstBehaviour: FirstBehaviour, secondBehaviour: SecondBehaviour) {
    self.firstBehaviour = firstBehaviour
    self.secondBehaviour = secondBehaviour
  }

  public func perform(from view: FirstBehaviour.FromView) throws -> SecondBehaviour.ToView {
    let intermediateView = try firstBehaviour.perform(from: view)
    return try secondBehaviour.perform(from: intermediateView)
  }
}
