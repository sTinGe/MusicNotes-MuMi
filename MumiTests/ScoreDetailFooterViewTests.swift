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
        let playExpectation = XCTestExpectation(description: "onPlay closure was called")
        let stopExpectation = XCTestExpectation(description: "onStop closure was called")
        
        let view = ScoreDetailFooterView(onPlay: {
            playExpectation.fulfill()
        }, onStop: {
            stopExpectation.fulfill()
        })

        // 2. Act
        let inspectedView = try view.inspect()
        let playButton = try inspectedView.find(viewWithAccessibilityIdentifier: AccessibilityIdentifiers.playButton)
        let stopButton = try inspectedView.find(viewWithAccessibilityIdentifier: AccessibilityIdentifiers.stopButton)
        
        try playButton.button().tap()
        try stopButton.button().tap()
        
        // 3. Assert
        wait(for: [playExpectation, stopExpectation], timeout: 0.1)
    }
}
