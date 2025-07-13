//
//  HeaderViewTests.swift
//  MumiTests
//
//  Created by Gemini on 2025/07/13.
//

import XCTest
import SwiftUI
import ViewInspector
@testable import Mumi

final class HeaderViewTests: XCTestCase {

    func testHeaderView_displaysAllComponents() throws {
        // 1. Arrange
        let addActionExpectation = XCTestExpectation(description: "Add action was called")
        let view = HeaderView(onAdd: {
            addActionExpectation.fulfill()
        })

        // 2. Act
        let inspectedView = try view.inspect()

        // 3. Assert
        // Find components using their accessibility identifiers
        XCTAssertNoThrow(try inspectedView.find(viewWithAccessibilityIdentifier: AccessibilityIdentifiers.headerImage))
        XCTAssertNoThrow(try inspectedView.find(viewWithAccessibilityIdentifier: AccessibilityIdentifiers.searchField))
        
        // Find the button and simulate a tap
        let addButton = try inspectedView.find(viewWithAccessibilityIdentifier: AccessibilityIdentifiers.addButton)
        try addButton.button().tap()
        
        wait(for: [addActionExpectation], timeout: 1.0)
    }
}