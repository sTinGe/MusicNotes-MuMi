import XCTest
@testable import Mumi

class ScoreServiceTests: XCTestCase {

    var scoreService: ScoreService!
    var documentsDirectory: URL!

    override func setUpWithError() throws {
        try super.setUpWithError()
        scoreService = ScoreService() // Use default initializer
        documentsDirectory = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        )[0]
        // Clean up documents directory before each test
        let fileURLs = try FileManager.default.contentsOfDirectory(
            at: documentsDirectory, includingPropertiesForKeys: nil
        )
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

    func test_renameScore_renamesFile() throws {
        let bundle = Bundle(for: type(of: self))
        guard let sourceURL = bundle.url(forResource: "blank", withExtension: "pdf") else {
            XCTFail("blank.pdf not found in test bundle")
            return
        }
        let initialURL = documentsDirectory.appendingPathComponent(sourceURL.lastPathComponent)
        try FileManager.default.copyItem(at: sourceURL, to: initialURL)
        let score = Score(filename: initialURL.lastPathComponent, url: initialURL)
        let newFilename = "renamed.pdf"

        let newURL = scoreService.renameScore(score: score, newFilename: newFilename)

        XCTAssertNotNil(newURL)
        XCTAssertTrue(FileManager.default.fileExists(atPath: newURL!.path))
        XCTAssertFalse(FileManager.default.fileExists(atPath: initialURL.path))
        XCTAssertEqual(newURL?.lastPathComponent, newFilename)
    }

    func test_importScore_handlesCopyError() throws {
        let mockFileManager = MockFileManager()
        scoreService = ScoreService(fileManager: mockFileManager) // Inject mock
        mockFileManager.shouldThrowOnCopy = true

        let bundle = Bundle(for: type(of: self))
        guard let sourceURL = bundle.url(forResource: "blank", withExtension: "pdf") else {
            XCTFail("blank.pdf not found in test bundle")
            return
        }

        scoreService.importScore(from: sourceURL)

        // Assert that the file was not copied due to the error
        let destinationURL = documentsDirectory.appendingPathComponent(sourceURL.lastPathComponent)
        XCTAssertFalse(FileManager.default.fileExists(atPath: destinationURL.path))
    }

    func test_deleteScore_handlesDeleteError() throws {
        let mockFileManager = MockFileManager()
        scoreService = ScoreService(fileManager: mockFileManager) // Inject mock
        mockFileManager.shouldThrowOnDelete = true

        let bundle = Bundle(for: type(of: self))
        guard let sourceURL = bundle.url(forResource: "blank", withExtension: "pdf") else {
            XCTFail("blank.pdf not found in test bundle")
            return
        }
        let destinationURL = documentsDirectory.appendingPathComponent(sourceURL.lastPathComponent)
        try FileManager.default.copyItem(at: sourceURL, to: destinationURL)
        let score = Score(filename: destinationURL.lastPathComponent, url: destinationURL)

        scoreService.deleteScore(score)

        // Assert that the file still exists due to the error
        XCTAssertTrue(FileManager.default.fileExists(atPath: destinationURL.path))
    }
}

// Mock FileManager for testing error scenarios
class MockFileManager: FileManager {
    var shouldThrowOnCopy = false
    var shouldThrowOnDelete = false

    override func copyItem(at srcURL: URL, to dstURL: URL) throws {
        if shouldThrowOnCopy {
            throw NSError(domain: "MockError", code: 100, userInfo: [NSLocalizedDescriptionKey: "Mock copy error"])
        }
        try super.copyItem(at: srcURL, to: dstURL)
    }

    override func removeItem(at URL: URL) throws {
        if shouldThrowOnDelete {
            throw NSError(domain: "MockError", code: 101, userInfo: [NSLocalizedDescriptionKey: "Mock delete error"])
        }
        try super.removeItem(at: URL)
    }
}
