//
//  Keywords.swift
//  Gherkin
//
//  Created by Frederic FAUQUETTE on 22/01/2020.
//

import Foundation
import Gherkin

extension String {
    // inspired by: https://www.hackingwithswift.com/articles/108/how-to-use-regular-expressions-in-swift

    /// get the firstmatch for the pattern (pattern will be evaluate as a regex
    /// return nil if no match is found or if the regex if not valid
    /// - Parameter regex: the regex to be evaluated
    func firstMatch(_ regex: NSRegularExpression) -> NSTextCheckingResult? {
        let range = NSRange(location: 0, length: utf16.count)
        return regex.firstMatch(in: self, options: [], range: range)
    }

    /// add the right thing to make the regex fit with exactly the pattern (so user is not forced to add them in the pattern)
    var exactMatch: String {
        "^\(self)$"
    }
}

extension NSTextCheckingResult {
    // TODO: find a better way...
    /// generate ranges from the Object (maybe there's a better way but could not find one...)
    var ranges: [NSRange]? {
        guard numberOfRanges > 0 else {
            return nil
        }
        var ranges = [NSRange]()
        for i in 0 ..< numberOfRanges {
            ranges.append(range(at: i))
        }
        return ranges
    }
}

/// An error to describe the potential Result of a search
public enum SearchError: Error {
    /// the regex was not found
    case notFound
    /// the regex is invalid
    case invalidRegex(Error?)
    /// no scenario
    case undefinedScenario
}

public struct SearchResult {
    public let matches: [String]?
    public let step: Step
}

/// A completion used at the end of every search: it will generate a Result
/// In case of success, the Result contains every string that was a match i.e.:
/// If you search for "I am a given with value (\\d)" in a text like "I am a given with value 2", you will have 2 strings in the array:
/// "I am a given with value 2" and "2"
public typealias GherkinRegexCompletion = (Result<SearchResult, SearchError>) -> Void

/// Search for a step in a scenario
/// - Parameters:
///   - scenario: the scenario
///   - text: the regex
///   - stepName: the type of step (i.e.: Given, Then, etc.)
///   - completion: the completion executed at the end of the search
func search(_ scenario: Scenario?, _ text: String, _ stepName: StepName, _ completion: GherkinRegexCompletion) {
    guard let scenario = scenario else {
        completion(.failure(.undefinedScenario))
        return
    }
    do {
        guard let step = try scenario.steps(for: text, stepName)?.first else {
            completion(.failure(.notFound))
            return
        }
        let regex = try NSRegularExpression(pattern: text.exactMatch, options: .caseInsensitive)
        let match = step.text.firstMatch(regex)
        completion(.success(SearchResult(matches: match?.ranges?.compactMap { (step.text as NSString).substring(with: $0) },
                                         step: step)))
    } catch {
        completion(.failure(.invalidRegex(error)))
    }
}

/// A completion used at the end of every search: it will generate a SearchResult
/// the Result contains every string that was a match i.e.:
/// If you search for "I am a given with value (\\d)" in a text like "I am a given with value 2", you will have 2 strings in the array:
/// "I am a given with value 2" and "2"
public typealias GherkinSearchResultCompletion = (SearchResult) -> Void

/// Search for a step in a scenario
/// - Parameters:
///   - scenario: the scenario
///   - text: the regex
///   - stepName: the type of step (i.e.: Given, Then, etc.)
///   - completion: the completion executed at the end of the search
func search(_ scenario: Scenario?, _ text: String, _ stepName: StepName, _ completion: GherkinSearchResultCompletion) throws {
    guard let scenario = scenario else {
        throw SearchError.undefinedScenario
    }
    guard let step = try scenario.steps(for: text, stepName)?.first else {
        throw SearchError.notFound
    }
    let regex = try NSRegularExpression(pattern: text.exactMatch, options: .caseInsensitive)
    let match = step.text.firstMatch(regex)
    completion(SearchResult(matches: match?.ranges?.compactMap { (step.text as NSString).substring(with: $0) },
                            step: step))
}
