
import XCTest

final class ScoreLibraryUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launchArguments = ["-uiTestMode"]
        app.launch()
    }

    func testTapScoreThumbnailToNavigateToDetailView() throws {
        let scoreThumbnail = app.images[AccessibilityIdentifiers.scoreThumbnailPlaceholder]
        XCTAssertTrue(scoreThumbnail.waitForExistence(timeout: 5))

        scoreThumbnail.tap()

        let detailView = app.otherElements[AccessibilityIdentifiers.scoreDetailView]
        XCTAssertTrue(detailView.waitForExistence(timeout: 5))
    }
}
