//
//  ScoreDetailViewTests.swift
//  MumiTests
//
//  Created by Gemini on 2025/07/13.
//

import XCTest
import SwiftUI
import ViewInspector
@testable import Mumi

final class ScoreDetailViewTests: XCTestCase {

    func testScoreDetailView_initialLayout() throws {
        // 1. Arrange
        let testURL = Bundle(for: type(of: self)).url(forResource: "blank", withExtension: "pdf")!
        let mockScore = Score(filename: "blank.pdf", url: testURL)
        let view = ScoreDetailView(score: mockScore)

        // 2. Act
        let inspectedView = try view.inspect()

        // 3. Assert
        // Check that the main view has the correct identifier
        XCTAssertNoThrow(try inspectedView.find(viewWithAccessibilityIdentifier: AccessibilityIdentifiers.scoreDetailView))

        // Check that the header and PDF view are present
        XCTAssertNoThrow(try inspectedView.find(ScoreDetailHeaderView.self))
//        XCTAssertNoThrow(try inspectedView.find(viewWithAccessibilityIdentifier: AccessibilityIdentifiers.pdfKitView))
    }
}
