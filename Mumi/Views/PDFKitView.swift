import SwiftUI
import PDFKit

struct PDFKitView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = PDFDocument(url: self.url)
        pdfView.autoScales = true
        pdfView.displayMode = .singlePageContinuous
        for subview in pdfView.subviews {
            if let scrollView = subview as? UIScrollView {
                scrollView.showsVerticalScrollIndicator = false
                break
            }
        }
        return pdfView
    }

    func updateUIView(_ uiView: PDFView, context: Context) {
        // We can update the view here if needed.
    }
}
