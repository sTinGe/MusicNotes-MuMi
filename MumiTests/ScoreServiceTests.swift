import XCTest
@testable import Mumi

class ScoreServiceTests: XCTestCase {

    var scoreService: ScoreService!
    var documentsDirectory: URL!

    override func setUpWithError() throws {
        try super.setUpWithError()
        scoreService = ScoreService()
        documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        // Clean up documents directory before each test
        let fileURLs = try FileManager.default.contentsOfDirectory(at: documentsDirectory, includingPropertiesForKeys: nil)
        for fileURL in fileURLs {
            try FileManager.default.removeItem(at: fileURL)
        }
    }

    override func tearDownWithError() throws {
        scoreService = nil
        documentsDirectory = nil
        try super.tearDownWithError()
    }

    func test_importScore_copiesFileToDocumentsDirectory() throws {
        let bundle = Bundle(for: type(of: self))
        guard let sourceURL = bundle.url(forResource: "blank", withExtension: "pdf") else {
            XCTFail("blank.pdf not found in test bundle")
            return
        }

        scoreService.importScore(from: sourceURL)

        let destinationURL = documentsDirectory.appendingPathComponent(sourceURL.lastPathComponent)
        XCTAssertTrue(FileManager.default.fileExists(atPath: destinationURL.path))
    }

    func test_deleteScore_removesFileFromDocumentsDirectory() throws {
        let bundle = Bundle(for: type(of: self))
        guard let sourceURL = bundle.url(forResource: "blank", withExtension: "pdf") else {
            XCTFail("blank.pdf not found in test bundle")
            return
        }
        let destinationURL = documentsDirectory.appendingPathComponent(sourceURL.lastPathComponent)
        try FileManager.default.copyItem(at: sourceURL, to: destinationURL)
        let score = Score(filename: destinationURL.lastPathComponent, url: destinationURL)

        scoreService.deleteScore(score)

        XCTAssertFalse(FileManager.default.fileExists(atPath: destinationURL.path))
    }

    func test_fetchScores_returnsImportedScores() throws {
        let bundle = Bundle(for: type(of: self))
        guard let sourceURL = bundle.url(forResource: "blank", withExtension: "pdf") else {
            XCTFail("blank.pdf not found in test bundle")
            return
        }

        scoreService.importScore(from: sourceURL)

        let scores = scoreService.fetchScores()
        XCTAssertEqual(scores.count, 1)
        XCTAssertEqual(scores.first?.filename, "blank.pdf")
    }

    func test_generateThumbnail_returnsImageForValidPDF() throws {
        let bundle = Bundle(for: type(of: self))
        guard let sourceURL = bundle.url(forResource: "blank", withExtension: "pdf") else {
            XCTFail("blank.pdf not found in test bundle")
            return
        }

        let thumbnail = scoreService.generateThumbnail(for: sourceURL)
        XCTAssertNotNil(thumbnail)
    }

    func test_generateThumbnail_returnsNilForInvalidPDF() throws {
        let invalidURL = URL(string: "file:///invalid.pdf")!
        let thumbnail = scoreService.generateThumbnail(for: invalidURL)
        XCTAssertNil(thumbnail)
    }
}
