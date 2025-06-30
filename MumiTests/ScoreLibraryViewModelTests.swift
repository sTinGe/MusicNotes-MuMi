
import XCTest
@testable import Mumi

class ScoreLibraryViewModelTests: XCTestCase {

    var viewModel: ScoreLibraryViewModel!
    var scoreService: ScoreService!
    var documentsDirectory: URL!

    override func setUpWithError() throws {
        try super.setUpWithError()
        viewModel = ScoreLibraryViewModel()
        scoreService = ScoreService()
        documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        // Clean up documents directory before each test
        let fileURLs = try FileManager.default.contentsOfDirectory(at: documentsDirectory, includingPropertiesForKeys: nil)
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
}
