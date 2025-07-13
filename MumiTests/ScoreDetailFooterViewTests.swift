//
//  ScoreDetailFooterViewTests.swift
//  MumiTests
//
//  Created by Gemini on 2025/07/13.
//

import XCTest
import SwiftUI
import ViewInspector
@testable import Mumi

final class ScoreDetailFooterViewTests: XCTestCase {

    func testScoreDetailFooterView_buttonsAreTappable() throws {
        // 1. Arrange
        let playExpectation = XCTestExpectation(description: "Play action was called")
        let stopExpectation = XCTestExpectation(description: "Stop action was called")
        
        let view = ScoreDetailFooterView(onPlay: {
            playExpectation.fulfill()
        }, onStop: {
            stopExpectation.fulfill()
        })

        let exp = view.inspection.inspect { inspectedView in
            // 2. Act
            let playButton = try inspectedView.find(viewWithAccessibilityIdentifier: AccessibilityIdentifiers.playButton)
            let stopButton = try inspectedView.find(viewWithAccessibilityIdentifier: AccessibilityIdentifiers.stopButton)
            
            try playButton.button().tap()
            try stopButton.button().tap()
        }
        
        // 3. Assert
        ViewHosting.host(view: view)
        wait(for: [exp, playExpectation, stopExpectation], timeout: 1.0)
    }
}
