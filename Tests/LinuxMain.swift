import XCTest

import reposTests

var tests = [XCTestCaseEntry]()
tests += reposTests.allTests()
XCTMain(tests)
