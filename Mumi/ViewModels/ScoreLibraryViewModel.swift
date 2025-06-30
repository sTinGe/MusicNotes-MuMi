import Foundation

class ScoreLibraryViewModel: ObservableObject {
    @Published var scores: [Score] = []

    private let scoreService: ScoreService

    init() {
        if ProcessInfo.processInfo.arguments.contains("-uiTestMode") {
            self.scoreService = MockScoreService()
        } else {
            self.scoreService = ScoreService()
        }
    }

    func loadScores() {
        self.scores = scoreService.fetchScores()
    }

    func importScore(from url: URL) {
        scoreService.importScore(from: url)
        loadScores()
    }

    func deleteScore(_ score: Score) {
        scoreService.deleteScore(score)
        loadScores()
    }
}
