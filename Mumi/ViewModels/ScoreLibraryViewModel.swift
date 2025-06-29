import Foundation

class ScoreLibraryViewModel: ObservableObject {
    @Published var scores: [Score] = []

    private let scoreService = ScoreService()

    func loadScores() {
        self.scores = scoreService.fetchScores()
    }
}
