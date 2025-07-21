import SwiftUI

struct ProgressBarView: View {
    var progress: CGFloat

    var viewHeight: CGFloat = 24

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(Color.gray.opacity(0.3))
                    .frame(width: geometry.size.width, height: viewHeight)
                Rectangle()
                    .foregroundColor(Color.blue)
                    .frame(width: min(progress * geometry.size.width, geometry.size.width), height: viewHeight)
                    .accessibilityIdentifier(AccessibilityIdentifiers.progressBarForeground)
                Text(String(format: "%.0f%%", min(progress, 1.0) * 100))
                    .font(.body)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .padding(.horizontal)
                    .accessibilityIdentifier(AccessibilityIdentifiers.progressBarPercentageText)
            }
            .cornerRadius(10)
        }
        .frame(height: viewHeight)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBarView(progress: 0.5)
            .padding(.horizontal, 8)
    }
}
