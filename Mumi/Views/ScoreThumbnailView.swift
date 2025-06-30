import SwiftUI

struct ScoreThumbnailView: View {
    let score: Score
    @State private var thumbnail: UIImage? = nil

    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                if let uiImage = thumbnail {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } else {
                    Text(score.filename)
                        .font(.system(size: 18, weight: .semibold))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.Theme.text)
                        .padding(5)
                }
            }
            .frame(width: 130, height: 150)
            .background(Color.Theme.surface)
            .cornerRadius(8)
            .padding(-4)
            .accessibilityIdentifier(AccessibilityIdentifiers.scoreThumbnailPreviewArea)

            Text(score.filename)
                .font(.caption)
                .foregroundColor(Color.Theme.text)
                .lineLimit(1)
                .truncationMode(.tail)
        }
        .padding(15)
        .frame(minHeight: 200)
        .background(Color.Theme.surface)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.Theme.secondary, lineWidth: 1)
        )
        .contentShape(RoundedRectangle(cornerRadius: 12))
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
