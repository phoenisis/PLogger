import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(PLoggerTests.allTests),
				testCase(FormatterTests.allTests)
    ]
}
#endif
