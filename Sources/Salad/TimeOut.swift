//
//  TimeOut.swift
//  Salad
//
//  Created by Mathijs Kadijk on 28/07/2019.
//  Copyright © 2019 Q42. All rights reserved.
//

import Foundation

public enum TimeOut {
  /// Directly time out, do not wait at all
  case instant

  /// Time out for a regular network call that shortly blocks user interaction
  case regularNetworkCall

  /// Time that it should take to switch to another app
  case appSwitch

  /// There are cases where the ui takes a tiny bit of time to continue, sadly..
  case asyncUI

  /// Time out for the login network call that blocks user interaction
  case longNetworkCall

  public var timeInterval: TimeInterval {
    switch self {
    case .instant: return 0
    case .regularNetworkCall: return 10
    case .longNetworkCall: return 20
    case .appSwitch: return 10
    case .asyncUI: return 1
    }
  }
}
