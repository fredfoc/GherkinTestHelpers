//
//  File.swift
//
//
//  Created by Frederic FAUQUETTE on 13/05/2020.
//

import Foundation
@testable import GherkinTestHelpers

extension SearchError: Equatable {
    public static func == (lhs: SearchError, rhs: SearchError) -> Bool {
        switch (lhs, rhs) {
        case (.notFound, .notFound), (.invalidRegex, invalidRegex), (.undefinedScenario, .undefinedScenario):
            return true
        default:
            return false
        }
    }
}
