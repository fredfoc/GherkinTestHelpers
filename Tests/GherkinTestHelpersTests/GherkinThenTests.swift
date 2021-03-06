import Consumer
import Gherkin
@testable import GherkinTestHelpers
import XCTest

class GherkinThenTests: XCTestCase {
    var feature: Feature!
    var scenario: Scenario!

    override func setUp() {
        super.setUp()
        feature = try! Feature(#file, featurePath: "features/MyTest.feature")
        scenario = try! feature.scenario(for: "A Scenario")
    }

    func testThenMethodShouldExist() {
        let expectation = XCTestExpectation(description: "testThenMethodShouldExist")
        Then(scenario, "I am a then") { _ in
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }

    func testThenMethodShouldFindSpecificString() {
        let expectation = XCTestExpectation(description: "testThenMethodShouldFindSpecificString")
        var searchResult: Result<SearchResult, SearchError>?
        Then(scenario, "I am a then") { tmpResult in
            searchResult = tmpResult
            expectation.fulfill()
        }
        guard let result = searchResult else {
            XCTFail("searchResult should not be nil")
            return
        }
        switch result {
        case let .success(search):
            XCTAssertEqual(search.matches?.count, 1)
            XCTAssertEqual(search.matches?.first, "I am a then")
        case .failure:
            XCTFail("should be success")
        }
        wait(for: [expectation], timeout: 10.0)
    }

    func testThenMethodShouldNotFindSpecificString() {
        let expectation = XCTestExpectation(description: "testThenMethodShouldNotFindSpecificString")
        var searchResult: Result<SearchResult, SearchError>?
        Then(scenario, "I am not in the steps") { tmpResult in
            searchResult = tmpResult
            expectation.fulfill()
        }
        guard let result = searchResult else {
            XCTFail("searchResult should not be nil")
            return
        }
        switch result {
        case .success:
            XCTFail("should be failure")
        case let .failure(error):
            XCTAssertEqual(error, SearchError.notFound)
        }
        wait(for: [expectation], timeout: 10.0)
    }

    func testThenMethodShouldFindSpecificStringOrThrow() throws {
        let expectation = XCTestExpectation(description: "testThenMethodShouldFindSpecificStringOrThrow")
        var searchResult: SearchResult?
        try Then(from: scenario, "I am a then") { tmpResult in
            searchResult = tmpResult
            expectation.fulfill()
        }
        guard let result = searchResult else {
            XCTFail("searchResult should not be nil")
            return
        }
        XCTAssertEqual(result.matches?.count, 1)
        XCTAssertEqual(result.matches?.first, "I am a then")
        wait(for: [expectation], timeout: 10.0)
    }

    func testThenMethodShouldNotFindSpecificStringOrThrow() {
        XCTAssertThrowsError(try Then(from: scenario, "I am not in the steps") { _ in }) { error in
            XCTAssertEqual(error as? SearchError, SearchError.notFound)
        }
    }

    func testThenMethodShouldThrowWithNoScenario() {
        XCTAssertThrowsError(try Then(from: nil, "I am not in the steps") { _ in }) { error in
            XCTAssertEqual(error as? SearchError, SearchError.undefinedScenario)
        }
    }
}
