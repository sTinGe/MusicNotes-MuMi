import Foundation

class ScoreLibraryViewModel: ObservableObject {
    @Published var scores: [Score] = []

    let scoreService: ScoreService

    init(scoreService: ScoreService = ScoreService()) {
        self.scoreService = scoreService
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

    func renameScore(score: Score, newFilename: String, completion: @escaping (Bool) -> Void) {
        if let newURL = scoreService.renameScore(score: score, newFilename: newFilename) {
            if let index = scores.firstIndex(where: { $0.id == score.id }) {
                scores[index] = Score(filename: newURL.lastPathComponent, url: newURL)
                completion(true)
                return
            }
        }
        completion(false)
    }
}
