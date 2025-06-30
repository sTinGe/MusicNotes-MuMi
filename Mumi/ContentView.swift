//
//  ContentView.swift
//  Mumi
//
//  Created by stinge on 2025/06/29.
//

import SwiftUI

struct ScoreLibraryView: View {
    @StateObject private var viewModel = ScoreLibraryViewModel()
    @State private var isImporterPresented = false

    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]

    var body: some View {
        NavigationView {
            VStack {
                HeaderView(onAdd: {
                    isImporterPresented = true
                })

                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(viewModel.scores) { score in
                            NavigationLink(destination: ScoreDetailView(score: score)) {
                                ScoreThumbnailView(score: score)
                            }
                            .buttonStyle(PlainButtonStyle())
                            .contextMenu {
                                Button(role: .destructive) {
                                    viewModel.deleteScore(score)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
            .background(Color.Theme.background)
            .onAppear {
                viewModel.loadScores()
            }
            .fileImporter(
                isPresented: $isImporterPresented,
                allowedContentTypes: [.pdf]
            ) { result in
                switch result {
                case .success(let url):
                    viewModel.importScore(from: url)
                    isImporterPresented = false
                case .failure(let error):
                    print("Error importing file: \(error.localizedDescription)")
                    isImporterPresented = false
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreLibraryView()
    }
}
