//
//  ScoreDetailHeaderViewTests.swift
//  MumiTests
//
//  Created by Gemini on 2025/07/13.
//

import XCTest
import SwiftUI
import ViewInspector
@testable import Mumi

final class ScoreDetailHeaderViewTests: XCTestCase {

    func testScoreDetailHeaderView_containsAllElementsAndBackButtonWorks() throws {
        // 1. Arrange
        let backActionExpectation = XCTestExpectation(description: "Back action was called")
        let progress = Binding.constant(CGFloat(0.5))
        
        let view = ScoreDetailHeaderView(onBack: {
            backActionExpectation.fulfill()
        }, progress: progress)

        // 2. Act
        let inspectedView = try view.inspect()
        let backButton = try inspectedView.find(viewWithAccessibilityIdentifier: AccessibilityIdentifiers.backButton)
        
        // 3. Assert
        // Check that the ProgressBarView is present
        XCTAssertNoThrow(try inspectedView.find(ProgressBarView.self))
        
        // Check that the back button is present and tapping it calls the closure
        try backButton.button().tap()
        wait(for: [backActionExpectation], timeout: 1.0)
    }
}
