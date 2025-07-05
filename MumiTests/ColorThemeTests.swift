
import XCTest
import SwiftUI
@testable import Mumi

class ColorThemeTests: XCTestCase {

    func test_allThemeColorsAreDefined() {
        _ = Color.Theme.background
        _ = Color.Theme.text
        _ = Color.Theme.accent
        _ = Color.Theme.primary
        _ = Color.Theme.onPrimary
        _ = Color.Theme.surface
        _ = Color.Theme.onSurface
        _ = Color.Theme.secondary
        _ = Color.Theme.onSecondary
        _ = Color.Theme.error
        _ = Color.Theme.onError
        XCTAssertTrue(true, "All theme colors can be accessed without crashing")
    }

    func test_colorValues() {
        // These tests are basic and only check if the color is not nil.
        // To properly test color values, you would need to render them and
        // check their RGBA components, which is complex for unit tests.
        // This at least ensures they are initialized.
        XCTAssertNotNil(Color.Theme.background)
        XCTAssertNotNil(Color.Theme.text)
        XCTAssertNotNil(Color.Theme.accent)
        XCTAssertNotNil(Color.Theme.primary)
        XCTAssertNotNil(Color.Theme.onPrimary)
        XCTAssertNotNil(Color.Theme.surface)
        XCTAssertNotNil(Color.Theme.onSurface)
        XCTAssertNotNil(Color.Theme.secondary)
        XCTAssertNotNil(Color.Theme.onSecondary)
        XCTAssertNotNil(Color.Theme.error)
        XCTAssertNotNil(Color.Theme.onError)
    }
}
