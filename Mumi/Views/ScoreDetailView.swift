import SwiftUI

struct ScoreDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    let score: Score

    @State private var progress: CGFloat = 0.0

    var body: some View {
        VStack(spacing: 0) {
            ScoreDetailHeaderView(onBack: {
                self.presentationMode.wrappedValue.dismiss()
            }, progress: $progress)
            PDFKitView(url: score.url)
                .padding(16)
                .accessibilityIdentifier(AccessibilityIdentifiers.pdfKitView)
//            ScoreDetailFooterView(onPlay: {
//                // TODO: Implement play functionality
//            }, onStop: {
//                // TODO: Implement stop functionality
//            })
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .background(Color.Theme.background)
        .accessibilityIdentifier(AccessibilityIdentifiers.scoreDetailView)
    }
}
