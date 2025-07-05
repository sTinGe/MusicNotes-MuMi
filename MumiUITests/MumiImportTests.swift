import XCTest

class MumiImportTests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        // Clean up any imported scores if necessary
        // This might involve deleting the imported score from the app's data
        // For now, we'll assume the app's state is reset for each test run
    }

    func testImportPDF() throws {
        // Tap the add button
        app.buttons[AccessibilityIdentifiers.addButton].tap()

        // Tap on "Call_Of_Silence.pdf"
        // Assuming Call_Of_Silence.pdf is directly visible or easily accessible from the initial document picker view.
        let callOfSilencePdf = app.collectionViews.staticTexts["Call_Of_Silence"]
        XCTAssertTrue(callOfSilencePdf.waitForExistence(timeout: 10), "Call_Of_Silence.pdf should be visible in the document picker.")
        callOfSilencePdf.tap()

        // Verify that the score appears in the library
        let importedScore = app.staticTexts["Call_Of_Silence"]
        XCTAssertTrue(importedScore.waitForExistence(timeout: 10), "Imported 'Call_Of_Silence.pdf' score should be visible in the library")
    }
}
