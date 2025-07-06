import XCTest

final class MumiLongPressTests: XCTestCase {

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

    func testLongPressToScoreThumbnailViewAfterImport() throws {
        let importedScore = app.staticTexts.firstMatch
        importedScore.press(forDuration: 2.0)
//        let rename = app.collectionViews.firstMatch
//        rename.tap()
    }
}
