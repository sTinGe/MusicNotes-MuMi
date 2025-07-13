import SwiftUI

struct ScoreDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    let score: Score

    @State private var progress: CGFloat = 0.0
    @State private var isShowingPlaybackPanel = false

    var body: some View {
        VStack(spacing: 0) {
            ScoreDetailHeaderView(onBack: {
                self.presentationMode.wrappedValue.dismiss()
            }, progress: $progress)
            PDFKitView(url: score.url)
                .padding(16)
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .background(Color.Theme.background)
        .accessibilityIdentifier(AccessibilityIdentifiers.scoreDetailView)
        .overlay(alignment: .bottomTrailing) {
            Button {
                isShowingPlaybackPanel.toggle()
            } label: {
                Image(systemName: "light.panel.fill")
                    .font(.largeTitle)
                    .padding()
                    .background(Color.Theme.surface)
                    .foregroundColor(Color.Theme.onSurface)
                    .clipShape(Circle())
                    .shadow(radius: 5)
            }
            .padding(32)
        }
        .overlay {
            PlaybackControlPanel(score: score, isShowing: $isShowingPlaybackPanel)
        }
    }
}
