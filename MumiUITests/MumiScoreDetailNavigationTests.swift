import XCTest

final class MumiScoreDetailNavigationTests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        // Clean up any imported scores if necessary
        // For now, we'll assume the app's state is reset for each test run
    }

    func testNavigateToScoreDetailViewAfterImport() throws {
        // 1. Import the PDF (reusing logic from MumiImportTests)
        app.buttons[AccessibilityIdentifiers.addButton].tap()

        let callOfSilencePdf = app.collectionViews.staticTexts["Call_Of_Silence"]
        XCTAssertTrue(callOfSilencePdf.waitForExistence(timeout: 10),
                      "Call_Of_Silence.pdf should be visible in the document picker.")

        app.buttons["Cancel"].tap()

        // 2. Tap on the imported score to navigate to its detail view
        let importedScore = app.staticTexts.firstMatch
        importedScore.tap()

        // 3. Verify that the ScoreDetailView is displayed
        let scoreDetailView = app.otherElements[AccessibilityIdentifiers.scoreDetailView]
        XCTAssertTrue(scoreDetailView.waitForExistence(timeout: 10),
                      "ScoreDetailView should be displayed after tapping the imported score.")
    }
}
