import Consumer
import Gherkin
@testable import GherkinTestHelpers
import XCTest

class GherkinAndTests: XCTestCase {
    var feature: Feature!
    var scenario: Scenario!

    override func setUp() {
        super.setUp()
        feature = try! Feature(#file, featurePath: "features/MyTest.feature")
        scenario = try! feature.scenario(for: "A Scenario")
    }

    func testAndMethodShouldExist() {
        let expectation = XCTestExpectation(description: "testAndMethodShouldExist")
        And(scenario, "I am a and") { _ in
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }

    func testAndMethodShouldFindSpecificString() {
        let expectation = XCTestExpectation(description: "testAndMethodShouldFindSpecificString")
        var searchResult: Result<SearchResult, SearchError>?
        And(scenario, "I am a and") { tmpResult in
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
            XCTAssertEqual(search.matches?.first, "I am a and")
        case .failure:
            XCTFail("should be success")
        }
        wait(for: [expectation], timeout: 10.0)
    }

    func testAndMethodShouldNotFindSpecificString() {
        let expectation = XCTestExpectation(description: "testAndMethodShouldNotFindSpecificString")
        var searchResult: Result<SearchResult, SearchError>?
        And(scenario, "I am not in the steps") { tmpResult in
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

    func testAndMethodShouldRaiseAnErrorWhenScenarioIsNil() {
        let expectation = XCTestExpectation(description: "testAndMethodShouldRaiseAnErrorWhenScenarioIsNil")
        var searchResult: Result<SearchResult, SearchError>?
        And(nil, "I am not in the steps") { tmpResult in
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
            XCTAssertEqual(error, SearchError.undefinedScenario)
        }
        wait(for: [expectation], timeout: 10.0)
    }

    func testAndMethodShouldFindSpecificStringOrThrow() throws {
        let expectation = XCTestExpectation(description: "testAndMethodShouldFindSpecificStringOrThrow")
        var searchResult: SearchResult?
        try And(from: scenario, "I am a and") { tmpResult in
            searchResult = tmpResult
            expectation.fulfill()
        }
        guard let result = searchResult else {
            XCTFail("searchResult should not be nil")
            return
        }
        XCTAssertEqual(result.matches?.count, 1)
        XCTAssertEqual(result.matches?.first, "I am a and")
        wait(for: [expectation], timeout: 10.0)
    }

    func testAndMethodShouldNotFindSpecificStringOrThrow() {
        XCTAssertThrowsError(try And(from: scenario, "I am not in the steps") { _ in }) { error in
            XCTAssertEqual(error as? SearchError, SearchError.notFound)
        }
    }

    func testAndMethodShouldThrowWithNoScenario() {
        XCTAssertThrowsError(try And(from: nil, "I am not in the steps") { _ in }) { error in
            XCTAssertEqual(error as? SearchError, SearchError.undefinedScenario)
        }
    }
}
