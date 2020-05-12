# GherkinTestHelpers

[![Build Status](https://travis-ci.org/fredfoc/GherkinTestHelpers.svg?branch=master)](https://travis-ci.org/fredfoc/GherkinTestHelpers)

Some Helpers on top of [SwiftGherkin](https://github.com/iainsmith/SwiftGherkin) library.

## Motivation
Write Tests based on Gherkin feature files and implement BDD as a standard practice with helpers method that enable to write tests close to the Cucumberish style.

## What is Gherkin
Gherkin is a syntax that enable testers to write simple tests without any coding requirement.

A gherkin test looks like this:

```
Feature: Test
a feature used for testing purpose

Scenario: A Scenario
Given I am a given
Given I am a given with value 2
Given I am a given with an example
|test value|
|I am a value|
And I am a and
When I am a when
Then I am a then
But I am a but
```
It works with keywords and arguments. To get a precise knowledge about it, I suggest to visit this website: [Gherkin Refernce](https://cucumber.io/docs/gherkin/reference/)


## How to install

### Using SPM
To install using Swift Package Manager, add this to the dependencies: section in your Package.swift file:

```
.package(name: "GherkinTestHelpers", url: "https://github.com/fredfoc/GherkinTestHelpers.git", .branch("master")),
```

<details>
<summary>Example Swift 5 Package</summary>

```swift
let package = Package(
    name: "MyPackage",
    products: [
        .library(
            name: "MyPackage",
            targets: ["MyPackage"]),
    ],
    dependencies: [
    .package(name: "GherkinTestHelpers", url: "https://github.com/fredfoc/GherkinTestHelpers.git", .branch("master")),
    ],
    targets: [
        .target(
            name: "MyPackage",
            dependencies: []),
        .testTarget(
            name: "MyPackageTests",
            dependencies: ["GherkinTestHelpers"]),
    ]
)
```
</details>

## How to use this Helpers
If we suppose that you have a feature like this:

```
Feature: Test
a feature used for testing purpose

Scenario: Name of the scenario
Given something you need to setup
Then something you want to assert
```

To write a test based on this feature and secnario, all you need to do is this:

```
import Gherkin
import GherkinTestHelpers
import XCTest

final class SomeTests: XCTestCase {
    func testSomething() {
        do {
            let feature = try Feature(#file, featurePath: "path to a feature file") // 1
            guard let scenario = try feature.scenario(for: "Name of the scenario") else { // 2
                XCTFail("no scenario")
                return
            }
            Given(scenario, "something you need to setup") { result in
                switch result {
                case .success:
                    // do some setup here
                case .failure:
                    XCTFail("no step")
                }
            }
            Then(scenario, "something you want to assert") { result in
                switch result {
                case .success:
                    // do some XCTAssert here
                case .failure:
                    XCTFail("no step")
                }
            }
        } catch {
            XCTFail("error:\(error)")
        }
    }
}
```

## Acknowledgements

GherkinTestHelpers is built on top of [SwiftGherkin](https://github.com/iainsmith/SwiftGherkin) by Iain Smith.
