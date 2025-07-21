import XCTest
import SwiftUI
import ViewInspector
@testable import Mumi

class PlaybackControlPanelTests: XCTestCase {

    func testInitialState() throws {
        let score = Score(filename: "dummy", url: URL(fileURLWithPath: "/path/to/dummy.pdf"))
        let view = PlaybackControlPanel(score: score, isShowing: .constant(true))

        // Check initial BPM text
        let bpmText = try view.inspect().find(viewWithAccessibilityIdentifier: AccessibilityIdentifiers.playbackControlPanelBpmText).text().string()
        XCTAssertEqual(bpmText, "- BPM")

        // Check initial play button icon
        let playButton = try view.inspect().find(viewWithAccessibilityIdentifier: AccessibilityIdentifiers.playbackControlPanelPlayButton).button()
        let playButtonImage = try playButton.labelView().image().actualImage().name()
        XCTAssertEqual(playButtonImage, "play.fill")
    }

    func testPlayButtonWithoutSettingTempo() throws {
        let score = Score(filename: "dummy", url: URL(fileURLWithPath: "/path/to/dummy.pdf"))
        let view = PlaybackControlPanel(score: score, isShowing: .constant(true))

        // Tap the play button without setting tempo
        let button = try view.inspect().find(viewWithAccessibilityIdentifier: AccessibilityIdentifiers.playbackControlPanelPlayButton).button()
        XCTAssertFalse(button.isDisabled())
        
        // Toast should be shown
        try button.tap()
        let playButtonImage = try button.labelView().image().actualImage().name()
        XCTAssertEqual(playButtonImage, "play.fill")
        
        let title = try view.inspect().find(viewWithAccessibilityIdentifier: AccessibilityIdentifiers.playbackControlPanelScoreTitle).text().string()
        XCTAssertEqual(title, "dummy")
    }

}
