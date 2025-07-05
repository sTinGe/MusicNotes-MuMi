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
    @State private var isRenameSheetPresented = false
    @State private var scoreToRename: Score? = nil
    @State private var newFilenameInput: String = ""

    let columns = [
        // add to be 300
        GridItem(.adaptive(minimum: 120)),
        GridItem(.adaptive(minimum: 180)),
        
    ]

    var body: some View {
        NavigationView {
            VStack {
                HeaderView(onAdd: {
                    isImporterPresented = true
                })

                ScrollView {
                    LazyVGrid(columns: columns, spacing: 8) {
                        ForEach(viewModel.scores) { score in
                            NavigationLink(destination: ScoreDetailView(score: score)) {
                                ScoreThumbnailView(score: score)
                            }
                            .buttonStyle(PlainButtonStyle())
                            .contextMenu {
                                Button {
                                    scoreToRename = score
                                    isRenameSheetPresented = true
                                } label: {
                                    Label("Rename", systemImage: "pencil").accessibilityIdentifier(AccessibilityIdentifiers.scoreThumbnailMenuButtonRenameLabel)
                                }
                                Button(role: .destructive) {
                                    viewModel.deleteScore(score)
                                } label: {
                                    Label("Delete", systemImage: "trash").accessibilityIdentifier(AccessibilityIdentifiers.scoreThumbnailMenuButtonDeleteLabel)
                                }
                            }
                        }
                    }
                }
                .padding(.top, 32)
            }
            .padding(.horizontal, 24)
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
        .navigationViewStyle(.stack)
        .alert("Rename Score", isPresented: Binding<Bool>(
            get: { scoreToRename != nil },
            set: { newValue in
                if !newValue { scoreToRename = nil }
            }
        )) {
            TextField("New Filename", text: $newFilenameInput)
            Button("Rename") {
                if let score = scoreToRename {
                    viewModel.renameScore(score: score, newFilename: newFilenameInput) { success in
                        // No need to call loadScores() here, viewModel handles it
                    }
                }
                scoreToRename = nil
                newFilenameInput = ""
            }
            Button("Cancel", role: .cancel) {
                scoreToRename = nil
                newFilenameInput = ""
            }
        } message: {
            Text("Enter a new name for \(scoreToRename?.filename ?? "this score").")
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ScoreLibraryView()
//    }
//}
