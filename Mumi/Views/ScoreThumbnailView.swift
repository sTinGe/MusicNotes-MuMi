import SwiftUI

struct ScoreThumbnailView: View {
    let score: Score
    @State private var thumbnail: UIImage?

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                if let uiImage = thumbnail {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .clipped()
                } else {
                    Rectangle()
                        .fill(Color.Theme.surface)
                    ProgressView()
                }
            }
            .aspectRatio(1 / 1.3, contentMode: .fit)
            .cornerRadius(8, corners: [.topLeft, .topRight])
            .padding(4)

            Text(score.url.deletingPathExtension().lastPathComponent)
                .font(.headline)
                .lineLimit(1)
                .foregroundColor(Color.Theme.text)
                .truncationMode(.tail)
                .padding(8)
                .frame(maxWidth: .infinity,
                       alignment: .leading)
                .background(Color.Theme.surface)
        }
        .cornerRadius(8)
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

private extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

private struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius),
        )
        return Path(path.cgPath)
    }
}
