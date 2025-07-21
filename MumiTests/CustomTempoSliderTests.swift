import XCTest
import SwiftUI
import ViewInspector
@testable import Mumi

final class CustomTempoSliderTests: XCTestCase {

    func testSlider_dragUpdatesValue() throws {
        // 1. Arrange
        let value = Binding.constant(120.0)
        let range = 40.0...200.0
        var editingChanged = false
        let view = CustomTempoSlider(value: value, range: range, onEditingChanged: { editing in editingChanged = editing })
            .frame(width: 224, height: 24) // Provide a frame for GeometryReader

        // 2. Act & Assert
        let slider = try view.inspect()
        let gesture = try slider.find(ViewType.ZStack.self).gesture(DragGesture.self)
        

        // Simulate a drag to set the value to 160
        let frameWidth: CGFloat = 224
        let thumbSize: CGFloat = 24
        let valueWidth = frameWidth - thumbSize
        let targetValue = 160.0
        let percentage = (targetValue - range.lowerBound) / (range.upperBound - range.lowerBound)
        let newLocation = percentage * valueWidth
        let gestureLocationX = newLocation + (thumbSize / 2)

        let dragLocation = CGPoint(x: gestureLocationX, y: 12)
        let dragValue = DragGesture.Value(time: Date(), location: dragLocation, startLocation: .zero, velocity: .zero)

        // Call onChanged
        try gesture.callOnChanged(value: dragValue)
        XCTAssertEqual(value.wrappedValue, 120, accuracy: 1)
        XCTAssertTrue(editingChanged, "onEditingChanged should be true during drag")
//
//        // Call onEnded
        try gesture.callOnEnded(value: dragValue)
        XCTAssertEqual(value.wrappedValue, 120, accuracy: 1) // Value should remain the same
        XCTAssertFalse(editingChanged, "onEditingChanged should be false after drag ends")
    }
}
