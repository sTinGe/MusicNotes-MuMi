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
                    .frame(width: 150, height: 200)
            }
            Text(score.filename)
                .font(.caption)
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
