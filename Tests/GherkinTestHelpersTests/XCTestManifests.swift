#if !canImport(ObjectiveC)
import XCTest

extension GherkinAndTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__GherkinAndTests = [
        ("testAndMethodShouldExist", testAndMethodShouldExist),
        ("testAndMethodShouldFindSpecificString", testAndMethodShouldFindSpecificString),
        ("testAndMethodShouldNotFindSpecificString", testAndMethodShouldNotFindSpecificString),
    ]
}

extension GherkinButTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__GherkinButTests = [
        ("testButMethodShouldExist", testButMethodShouldExist),
        ("testButMethodShouldFindSpecificString", testButMethodShouldFindSpecificString),
        ("testButMethodShouldNotFindSpecificString", testButMethodShouldNotFindSpecificString),
    ]
}

extension GherkinGivenTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__GherkinGivenTests = [
        ("testGivenMethodShouldExist", testGivenMethodShouldExist),
        ("testGivenMethodShouldFindGivenAndExample", testGivenMethodShouldFindGivenAndExample),
        ("testGivenMethodShouldFindSpecificRegex", testGivenMethodShouldFindSpecificRegex),
        ("testGivenMethodShouldFindSpecificString", testGivenMethodShouldFindSpecificString),
        ("testGivenMethodShouldNotFindSpecificStepIfNotARegex", testGivenMethodShouldNotFindSpecificStepIfNotARegex),
        ("testGivenMethodShouldNotFindSpecificString", testGivenMethodShouldNotFindSpecificString),
    ]
}

extension GherkinThenTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__GherkinThenTests = [
        ("testThenMethodShouldExist", testThenMethodShouldExist),
        ("testThenMethodShouldFindSpecificString", testThenMethodShouldFindSpecificString),
        ("testThenMethodShouldNotFindSpecificString", testThenMethodShouldNotFindSpecificString),
    ]
}

extension GherkinWhenTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__GherkinWhenTests = [
        ("testWhenMethodShouldExist", testWhenMethodShouldExist),
        ("testWhenMethodShouldFindSpecificString", testWhenMethodShouldFindSpecificString),
        ("testWhenMethodShouldNotFindSpecificString", testWhenMethodShouldNotFindSpecificString),
    ]
}

public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(GherkinAndTests.__allTests__GherkinAndTests),
        testCase(GherkinButTests.__allTests__GherkinButTests),
        testCase(GherkinGivenTests.__allTests__GherkinGivenTests),
        testCase(GherkinThenTests.__allTests__GherkinThenTests),
        testCase(GherkinWhenTests.__allTests__GherkinWhenTests),
    ]
}
#endif