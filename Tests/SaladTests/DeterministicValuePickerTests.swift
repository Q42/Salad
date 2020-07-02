//
//  DeterministicValuePickerTests.swift
//  SaladTests
//
//  Created by Mathijs Kadijk on 02/07/2020.
//

import XCTest
@testable import Salad

final class DeterministicValuePickerTests: XCTestCase {
  private let values = ["first", "second", "third", "fourth", "fifth"]

  func testPickedValueIsFromGivenList() throws {
    let picker = try DeterministicValuePicker(testName: name, seed: .generate)
    let pickedValue = picker.pickValue(from: values)

    XCTAssertTrue(values.contains(pickedValue), "Picked value was not from the given list of values")
  }

  func testHardcodedInputYieldsDeterministicResult() throws {
    let picker = try DeterministicValuePicker(testName: "HardcodedTestName", seed: "DEADBEEFED")
    let pickedValues = [
      picker.pickValue(from: values),
      picker.pickValue(from: values),
      picker.pickValue(from: values),
      picker.pickValue(from: values),
      picker.pickValue(from: values),
    ]

    let expectedValues = [
      "fourth",
      "first",
      "fifth",
      "first",
      "fourth",
    ]
    XCTAssertEqual(expectedValues, pickedValues)
  }

  func testClonedSeedYieldsDeterministicResult() throws {
    let generatedSeedPicker = try DeterministicValuePicker(testName: name, seed: .generate)
    let expectedPickedValues = [
      generatedSeedPicker.pickValue(from: values),
      generatedSeedPicker.pickValue(from: values),
      generatedSeedPicker.pickValue(from: values),
      generatedSeedPicker.pickValue(from: values),
      generatedSeedPicker.pickValue(from: values),
    ]

    let specifiedSeedPicker = try DeterministicValuePicker(testName: name, seed: .specified(generatedSeedPicker.seedHexString))
    let pickedValues = [
      specifiedSeedPicker.pickValue(from: values),
      specifiedSeedPicker.pickValue(from: values),
      specifiedSeedPicker.pickValue(from: values),
      specifiedSeedPicker.pickValue(from: values),
      specifiedSeedPicker.pickValue(from: values),
    ]

    XCTAssertEqual(expectedPickedValues, pickedValues)
  }

  func testInvalidSeed() throws {
    let invalidSeed = "FOOBAR"

    do {
      _ = try DeterministicValuePicker(testName: name, seed: .specified(invalidSeed))
      XCTFail("DeterministicValuePicker did accept invalid seed: '\(invalidSeed)'")
    } catch let DeterministicValuePicker.ArgumentError.invalidSeed(thrownSeed) {
      XCTAssertEqual(invalidSeed, thrownSeed)
    }
  }

  static var allTests = [
    ("testPickedValueIsFromGivenList", testPickedValueIsFromGivenList),
    ("testHardcodedInputYieldsDeterministicResult", testHardcodedInputYieldsDeterministicResult),
    ("testClonedSeedYieldsDeterministicResult", testClonedSeedYieldsDeterministicResult),
    ("testInvalidSeed", testInvalidSeed),
  ]
}
