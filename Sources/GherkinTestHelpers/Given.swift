//
//   Given.swift
//   Gherkin
//
//   Created by Frederic FAUQUETTE on 20/01/2020.
//

import Foundation
import Gherkin

/// Find a Given in a scenario
///  ~~~
///  let feature = try Feature(#file, featurePath: "/features/MyTest.feature")
///  guard let scenario = feature.scenario(for: "Successful Name") else {
///      XCTFail("no scenario")
///      return
///  }
///  Given(scenario, "I have a username in UserDefaults") { _ in
///      // Do something
///  }
///  ~~~
/// - Parameters:
///   - scenario: the scenario that contains the searched step
///   - string: the regex to describe the step (we add ^ and $ at the beginning and end of every regex and it is case insensitive)
///   - completion: the completion that will be executed at the end of the search with a `Result<SearchResult, SearchError>`

public func Given(_ scenario: Scenario?, _ string: String, _ completion: GherkinRegexCompletion) {
    search(scenario, string, .given, completion)
}

/// Find a Given in a scenario
///  ~~~
///  let feature = try Feature(#file, featurePath: "/features/MyTest.feature")
///  let scenario = try feature.scenario(for: "Successful Name")
///  try Given(from: scenario, "I want to display the current the name") { _ in
///      // Do something
///  }
///  ~~~
/// - Parameters:
///   - scenario: the scenario that contains the searched step
///   - string: the regex to describe the step (we add ^ and $ at the beginning and end of every regex and it is case insensitive)
///   - completion: the completion that will be executed at the end of the search with a `SearchResult`
public func Given(from scenario: Scenario?, _ string: String, _ completion: GherkinSearchResultCompletion) throws {
    try search(scenario, string, .given, completion)
}
