//
//  TimeOut.swift
//  Salad
//
//  Created by Mathijs Kadijk on 28/07/2019.
//  Copyright © 2019 Q42. All rights reserved.
//

import Foundation

/// Represents the length of the time out when waiting for something during your UI test to (dis)appear or finish.
///
/// Offers some sane default values to use, but is also easy to initialize with your own custom `TimeInterval`.
public struct TimeOut: ExpressibleByFloatLiteral, ExpressibleByIntegerLiteral, Equatable {
  public typealias IntegerLiteralType = TimeInterval
  public typealias FloatLiteralType = TimeInterval

  /// Directly time out, do not wait at all
  public static let instant: TimeOut = 0

  /// Appropiate time out for UI that is not rendered instantly, but waits for an animation completion or is dispatched to the next render loop for example
  public static let asyncUI: TimeOut = 1

  /// Appropiate time out for a fast network call that blocks user interaction, but is usually completed within a second
  public static let fastNetworkCall: TimeOut = 10

  /// Appropiate time out for launching and switching to another app, such as opening Safari from your app
  public static let appSwitch: TimeOut = 10

  /// Appropiate time out for a fast network call that blocks user interaction and is sometimes taking a few seconds
  public static let slowNetworkCall: TimeOut = 30

  /// The time interval of this time out
  public let timeInterval: TimeInterval

  public init(floatLiteral value: TimeInterval) {
    self.timeInterval = value
  }

  public init(integerLiteral value: TimeInterval) {
    self.timeInterval = value
  }
}
