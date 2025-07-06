import XCTest
@testable import Mumi

class ScoreLibraryViewModelTests: XCTestCase {

    var viewModel: ScoreLibraryViewModel!
    var scoreService: ScoreService!
    var documentsDirectory: URL!

    override func setUpWithError() throws {
        try super.setUpWithError()
        scoreService = ScoreService()
        viewModel = ScoreLibraryViewModel(scoreService: scoreService)
        documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        // Clean up documents directory before each test
        let fileURLs = try FileManager.default.contentsOfDirectory(
            at: documentsDirectory, includingPropertiesForKeys: nil
        )
        for fileURL in fileURLs {
            try FileManager.default.removeItem(at: fileURL)
        }
    }

    override func tearDownWithError() throws {
        viewModel = nil
        scoreService = nil
        documentsDirectory = nil
        try super.tearDownWithError()
    }

    func test_loadScores_loadsScoresFromService() {
        let bundle = Bundle(for: type(of: self))
        guard let sourceURL = bundle.url(forResource: "blank", withExtension: "pdf") else {
            XCTFail("blank.pdf not found in test bundle")
            return
        }
        scoreService.importScore(from: sourceURL)

        viewModel.loadScores()

        XCTAssertEqual(viewModel.scores.count, 1)
        XCTAssertEqual(viewModel.scores.first?.filename, "blank.pdf")
    }

    func test_importScore_importsScoreAndReloads() {
        let bundle = Bundle(for: type(of: self))
        guard let sourceURL = bundle.url(forResource: "blank", withExtension: "pdf") else {
            XCTFail("blank.pdf not found in test bundle")
            return
        }

        viewModel.importScore(from: sourceURL)

        XCTAssertEqual(viewModel.scores.count, 1)
        XCTAssertEqual(viewModel.scores.first?.filename, "blank.pdf")
    }

    func test_deleteScore_deletesScoreAndReloads() {
        let bundle = Bundle(for: type(of: self))
        guard let sourceURL = bundle.url(forResource: "blank", withExtension: "pdf") else {
            XCTFail("blank.pdf not found in test bundle")
            return
        }
        scoreService.importScore(from: sourceURL)
        viewModel.loadScores()
        guard let scoreToDelete = viewModel.scores.first else {
            XCTFail("Failed to load score to delete")
            return
        }

        viewModel.deleteScore(scoreToDelete)

        XCTAssertEqual(viewModel.scores.count, 0)
    }

    func test_renameScore_updatesScoreAndReloads() throws {
        let bundle = Bundle(for: type(of: self))
        guard let sourceURL = bundle.url(forResource: "blank", withExtension: "pdf") else {
            XCTFail("blank.pdf not found in test bundle")
            return
        }
        scoreService.importScore(from: sourceURL)
        viewModel.loadScores()
        guard let scoreToRename = viewModel.scores.first else {
            XCTFail("Failed to load score to rename")
            return
        }

        let newFilename = "renamed_blank.pdf"
        let expectation = XCTestExpectation(description: "Rename completion called")

        viewModel.renameScore(score: scoreToRename, newFilename: newFilename) { success in
            XCTAssertTrue(success)
            XCTAssertEqual(self.viewModel.scores.first?.filename, newFilename)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }

    func test_renameScore_handlesRenameError() throws {
        let mockScoreService = MockScoreService()
        mockScoreService.shouldFailRename = true
        viewModel = ScoreLibraryViewModel(scoreService: mockScoreService)

        let bundle = Bundle(for: type(of: self))
        guard let sourceURL = bundle.url(forResource: "blank", withExtension: "pdf") else {
            XCTFail("blank.pdf not found in test bundle")
            return
        }
        // Manually add a score to the view model's scores array for the test
        // since the mock service won't actually import it.
        let originalScore = Score(filename: sourceURL.lastPathComponent, url: sourceURL)
        viewModel.scores = [originalScore]

        let newFilename = "failed_rename.pdf"
        let expectation = XCTestExpectation(description: "Rename completion called")

        viewModel.renameScore(score: originalScore, newFilename: newFilename) { success in
            XCTAssertFalse(success)
            XCTAssertEqual(self.viewModel.scores.first?.filename, originalScore.filename)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
}

class MockScoreService: ScoreService {
    var shouldFailRename = false

    override func renameScore(score: Score, newFilename: String) -> URL? {
        if shouldFailRename {
            return nil
        }
        // Simulate successful rename by returning a new URL
        let newURL = score.url.deletingLastPathComponent().appendingPathComponent(newFilename)
        return newURL
    }

    // Override other methods if they are called and need specific behavior in tests
    override func fetchScores() -> [Score] {
        return []
    }

    override func importScore(from sourceURL: URL) {
        // Do nothing or simulate success based on test needs
    }

    override func deleteScore(_ score: Score) {
        // Do nothing or simulate success based on test needs
    }
}
