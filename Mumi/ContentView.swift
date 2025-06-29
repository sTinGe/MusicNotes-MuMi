//
//  ContentView.swift
//  Mumi
//
//  Created by stinge on 2025/06/29.
//

import SwiftUI

struct ScoreLibraryView: View {
    // Placeholder data
    let scores: [Score] = [
        Score(id: UUID(), filename: "Score 1.pdf", url: URL(string: "file:///score1.pdf")!),
        Score(id: UUID(), filename: "Score 2.pdf", url: URL(string: "file:///score2.pdf")!),
        Score(id: UUID(), filename: "Score 3.pdf", url: URL(string: "file:///score3.pdf")!)
    ]

    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(scores) { score in
                        ScoreThumbnailView(score: score)
                    }
                }
                .padding()
            }
            .navigationTitle("My Scores")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreLibraryView()
    }
}
