import Foundation
import PDFKit

class ScoreService {
    private var fileManager: FileManager

    init(fileManager: FileManager = .default) {
        self.fileManager = fileManager
    }
    private var documentsDirectory: URL {
        fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }

    func fetchScores() -> [Score] {
        do {
            let fileURLs = try fileManager.contentsOfDirectory(at: documentsDirectory, includingPropertiesForKeys: nil)
            return fileURLs.filter { $0.pathExtension == "pdf" }.map {
                Score(filename: $0.lastPathComponent, url: $0)
            }
        } catch {
            print("Error while enumerating files \(documentsDirectory.path): \(error.localizedDescription)")
            return []
        }
    }

    func importScore(from sourceURL: URL) {
        let shouldStopAccessing = sourceURL.startAccessingSecurityScopedResource()
        defer {
            if shouldStopAccessing {
                sourceURL.stopAccessingSecurityScopedResource()
            }
        }

        let destinationURL = documentsDirectory.appendingPathComponent(sourceURL.lastPathComponent)

        if fileManager.fileExists(atPath: destinationURL.path) {
            do {
                try fileManager.removeItem(at: destinationURL)
            } catch {
                print("Error removing existing file: \(error.localizedDescription)")
                return
            }
        }

        do {
            try fileManager.copyItem(at: sourceURL, to: destinationURL)
        } catch {
            print("Error copying file: \(error.localizedDescription)")
        }
    }

    func deleteScore(_ score: Score) {
        do {
            try fileManager.removeItem(at: score.url)
        } catch {
            print("Error deleting file: \(error.localizedDescription)")
        }
    }

    func generateThumbnail(for url: URL) -> UIImage? {
        guard let document = PDFDocument(url: url), let page = document.page(at: 0) else {
            return nil
        }
        return page.thumbnail(of: CGSize(width: 600, height: 800), for: .artBox)
    }

    func renameScore(score: Score, newFilename: String) -> URL? {
        let newURL = score.url.deletingLastPathComponent().appendingPathComponent(newFilename)
        do {
            try fileManager.moveItem(at: score.url, to: newURL)
            return newURL
        } catch {
            print("Error renaming file: \(error.localizedDescription)")
            return nil
        }
    }
}
