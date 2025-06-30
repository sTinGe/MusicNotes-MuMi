
import SwiftUI

struct ScoreDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    let score: Score

    var body: some View {
        VStack(spacing: 0) {
            ScoreDetailHeaderView(onBack: {
                self.presentationMode.wrappedValue.dismiss()
            })
            PDFKitView(url: score.url)
            ScoreDetailFooterView(onPlay: {
                // TODO: Implement play functionality
            }, onStop: {
                // TODO: Implement stop functionality
            })
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}
