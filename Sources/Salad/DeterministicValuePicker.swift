//
//  DeterministicValuePicker.swift
//  Salad
//
//  Created by Mathijs Kadijk on 31/07/2019.
//  Copyright © 2019 Q42. All rights reserved.
//

import Foundation
import GameplayKit
import XCTest

/// A basic "random" value picker, which is suitable for randomizing test data.
///
/// When you create an instance of this class it is both independent and deterministic—that is, the sequence of picked
/// values by one instance has no effect on what values are picked by any other instance, and that a sequence of picked
/// values can be replicated when necessary. For details on replicating sequences, the initializer documentation.
public final class DeterministicValuePicker {
  public enum Seed: ExpressibleByStringLiteral {
    case generate
    case specified(String)

    public init(stringLiteral value: String) {
      self = .specified(value)
    }
  }

  public enum ArgumentError: Error {
    case invalidTestName(String)
    case invalidSeed(String)
  }

  private static let generatedSeed = generateSeed()
  private let randomSource: GKARC4RandomSource

  /// Initializes a value picker with the specified seed.
  ///
  /// Any two value pickers initialized with the same test name and seed data will pick the same sequence of values. To
  /// replicate the behavior of an existing instance, check the `DeterministicValuePicker.log` attached to the test report
  /// and create a new `DeterministicValuePicker` by giving the test name and seed as seen in the log.
  ///
  /// - Parameters:
  ///     - testName: Name of the test this value picker will be used in
  ///     - seed: Whether to generate a seed to generate random values with or a specific seed string to use
  public init(testName: String, seed: Seed) throws {
    guard let testNameData = testName.data(using: .utf8) else {
      throw ArgumentError.invalidTestName(testName)
    }

    let seedData: Data
    let seedTypeUsed: String
    switch seed {
    case .generate:
      seedData = DeterministicValuePicker.generatedSeed
      seedTypeUsed = "Generated randomly"
    case let .specified(givenSeed):
      guard let givenSeedData = Data(hexString: givenSeed) else { throw ArgumentError.invalidSeed(givenSeed) }
      seedData = givenSeedData
      seedTypeUsed = "Explicitly given"
    }

    var randomSourceSeed = seedData
    randomSourceSeed.append(testNameData)
    randomSource = GKARC4RandomSource(seed: randomSourceSeed)

    let log = [
      "Seed type:  \(seedTypeUsed)",
      "Seed value: \(seedData.hexString)",
      "Test name:  \(testName)",
      "Random source input: \(randomSourceSeed.hexString)",
    ].joined(separator: "\n")

    XCTContext.runActivity(named: "Setting up DeterministicValuePicker") { activity in
      let attachment = XCTAttachment(string: log)
      attachment.name = "DeterministicValuePicker.log"
      attachment.lifetime = .keepAlways
      activity.add(attachment)
    }
  }

  public func pickValue<T>(from list: [T]) -> T {
    let randomIndex = randomSource.nextInt(upperBound: list.count)
    return list[randomIndex]
  }
}

private func generateSeed() -> Data {
  var bytes = [Int8](repeating: 0, count: 16)
  let status = SecRandomCopyBytes(kSecRandomDefault, bytes.count, &bytes)

  guard status == errSecSuccess else {
    fatalError("DeterministicValuePicker failed to copy new random bytes for a generated seed")
  }
  return Data(bytes: &bytes, count: bytes.count)
}

// swiftlint:disable identifier_name

private extension Data {
  init?(hexString: String) {
    let len = hexString.count / 2
    var data = Data(capacity: len)
    for i in 0 ..< len {
      let j = hexString.index(hexString.startIndex, offsetBy: i * 2)
      let k = hexString.index(j, offsetBy: 2)
      let bytes = hexString[j ..< k]
      if var num = UInt8(bytes, radix: 16) {
        data.append(&num, count: 1)
      } else {
        return nil
      }
    }
    self = data
  }

  var hexString: String {
    map { String(format: "%02hhx", $0) }.joined()
  }
}
