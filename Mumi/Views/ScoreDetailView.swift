
import SwiftUI

struct ScoreDetailView: View {
    let score: Score

    var body: some View {
        PDFKitView(url: score.url)
            .navigationTitle(score.filename)
            .navigationBarTitleDisplayMode(.inline)
    }
}
