//
//  ProgressBarViewTests.swift
//  MumiTests
//
//  Created by Gemini on 2025/07/13.
//

import XCTest
import SwiftUI
import ViewInspector
@testable import Mumi

final class ProgressBarViewTests: XCTestCase {

    func testProgressBar_updatesWidthAndText() throws {
        // 1. Arrange
        let progress: CGFloat = 0.75
        let view = ProgressBarView(progress: progress)
        let expectedPercentageText = "75%"

        // 2. Act
        let inspectedView = try view.inspect()
        let percentageText = try inspectedView.find(viewWithAccessibilityIdentifier: AccessibilityIdentifiers.progressBarPercentageText)

        // 3. Assert
        // Check the percentage text
        XCTAssertEqual(try percentageText.text().string(), expectedPercentageText)
    }
}
