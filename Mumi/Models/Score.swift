import Foundation

struct Score: Identifiable {
    var id: String { url.absoluteString }
    let filename: String
    let url: URL
}
