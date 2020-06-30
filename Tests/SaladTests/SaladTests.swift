import XCTest
@testable import Salad

final class SaladTests: XCTestCase {
  func testDeterministicValuePicker() throws {
    let picker = try DeterministicValuePicker(testName: "testDeterministicValuePicker", seed: .specified("DEADBEEFED"))
    XCTAssertEqual(picker.pickValue(from: Array(1...100)), 34)
    XCTAssertEqual(picker.pickValue(from: Array(1...100)), 41)
    XCTAssertEqual(picker.pickValue(from: Array(1...100)), 29)
    XCTAssertEqual(picker.pickValue(from: Array(1...100)), 13)
    XCTAssertEqual(picker.pickValue(from: Array(1...100)), 86)
  }
  
  static var allTests = [
    ("testDeterministicValuePicker", testDeterministicValuePicker),
  ]
}
