import Consumer
import Gherkin
@testable import GherkinTestHelpers
import XCTest

class GherkinWhenTests: XCTestCase {
    var feature: Feature!
    var scenario: Scenario!

    override func setUp() {
        super.setUp()
        feature = try! Feature(#file, featurePath: "features/MyTest.feature")
        scenario = try! feature.scenario(for: "A Scenario")
    }

    func testWhenMethodShouldExist() {
        let expectation = XCTestExpectation(description: "testWhenMethodShouldExist")
        When(scenario, "I am a when") { _ in
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }

    func testWhenMethodShouldFindSpecificString() {
        let expectation = XCTestExpectation(description: "testWhenMethodShouldFindSpecificString")
        var searchResult: Result<SearchResult, SearchError>?
        When(scenario, "I am a when") { tmpResult in
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
            XCTAssertEqual(search.matches?.first, "I am a when")
        case .failure:
            XCTFail("should be success")
        }
        wait(for: [expectation], timeout: 10.0)
    }

    func testWhenMethodShouldNotFindSpecificString() {
        let expectation = XCTestExpectation(description: "testWhenMethodShouldNotFindSpecificString")
        var searchResult: Result<SearchResult, SearchError>?
        When(scenario, "I am not in the steps") { tmpResult in
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

    func testWhenMethodShouldFindSpecificStringOrThrow() throws {
        let expectation = XCTestExpectation(description: "testWhenMethodShouldFindSpecificStringOrThrow")
        var searchResult: SearchResult?
        try When(from: scenario, "I am a when") { tmpResult in
            searchResult = tmpResult
            expectation.fulfill()
        }
        guard let result = searchResult else {
            XCTFail("searchResult should not be nil")
            return
        }
        XCTAssertEqual(result.matches?.count, 1)
        XCTAssertEqual(result.matches?.first, "I am a when")
        wait(for: [expectation], timeout: 10.0)
    }

    func testWhenMethodShouldNotFindSpecificStringOrThrow() {
        XCTAssertThrowsError(try When(from: scenario, "I am not in the steps") { _ in }) { error in
            XCTAssertEqual(error as? SearchError, SearchError.notFound)
        }
    }

    func testThenMethodShouldThrowWithNoScenario() {
        XCTAssertThrowsError(try When(from: nil, "I am not in the steps") { _ in }) { error in
            XCTAssertEqual(error as? SearchError, SearchError.undefinedScenario)
        }
    }
}
