import SwiftUI

struct ScoreThumbnailView: View {
    let score: Score

    var body: some View {
        VStack {
            // Placeholder for thumbnail image
            Image(systemName: "doc.text.image")
                .font(.largeTitle)
            Text(score.filename)
                .font(.caption)
        }
    }
}
