import Foundation

class MockScoreService: ScoreService {
    override func fetchScores() -> [Score] {
        let dummyURL = URL(fileURLWithPath: "/dev/null")
        return [Score(filename: "dummy.pdf", url: dummyURL)]
    }
}
