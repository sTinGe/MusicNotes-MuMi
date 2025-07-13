import SwiftUI

struct CustomTempoSlider: View {
    @Binding var value: Double
    var range: ClosedRange<Double>
    var onEditingChanged: (Bool) -> Void

    var body: some View {
        GeometryReader { geometry in
            let thumbSize: CGFloat = 24
            let trackHeight: CGFloat = 8
            let valueWidth = geometry.size.width - thumbSize

            let percentage = (value - range.lowerBound) / (range.upperBound - range.lowerBound)
            let thumbX = CGFloat(percentage) * valueWidth

            ZStack(alignment: .leading) {
                // Inactive Track
                Capsule()
                    .fill(Color.white.opacity(0.3))
                    .frame(width: geometry.size.width, height: trackHeight)

                // Active Track
                Capsule()
                    .fill(Color.white)
                    .frame(width: thumbX + (thumbSize / 2), height: trackHeight)

                // Thumb
                Circle()
                    .fill(Color.white)
                    .frame(width: thumbSize, height: thumbSize)
                    .shadow(radius: 2)
                    .offset(x: thumbX)
            }
            .frame(height: thumbSize) // Ensure the view has enough height for the thumb
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { gesture in
                        onEditingChanged(true)
                        let newLocation = gesture.location.x - (thumbSize / 2)
                        let newPercentage = newLocation / valueWidth
                        let clampedPercentage = min(max(0, newPercentage), 1)
                        let newValue = range.lowerBound + Double(clampedPercentage) * (range.upperBound - range.lowerBound)
                        self.value = newValue
                    }
                    .onEnded { _ in
                        onEditingChanged(false)
                    }
            )
        }
        .frame(height: 24) // Set a fixed height for the GeometryReader
    }
}
