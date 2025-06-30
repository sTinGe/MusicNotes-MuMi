import SwiftUI

struct ScoreThumbnailView: View {
    let score: Score
    @State private var thumbnail: UIImage? = nil

    var body: some View {
        VStack {
            if let thumbnail = thumbnail {
                Image(uiImage: thumbnail)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 200)
            } else {
                Image(systemName: "doc.text.image")
                    .font(.largeTitle)
                    .foregroundColor(Color.Theme.text.opacity(0.5))
                    .frame(width: 150, height: 200)
                    .accessibilityIdentifier(AccessibilityIdentifiers.scoreThumbnailPlaceholder)
            }
            Text(score.filename)
                .font(.caption)
                .foregroundColor(Color.Theme.text)
        }
        .onAppear {
            DispatchQueue.global(qos: .userInitiated).async {
                let scoreService = ScoreService()
                let generatedThumbnail = scoreService.generateThumbnail(for: score.url)
                DispatchQueue.main.async {
                    self.thumbnail = generatedThumbnail
                }
            }
        }
    }
}
