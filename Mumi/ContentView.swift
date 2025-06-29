//
//  ContentView.swift
//  Mumi
//
//  Created by stinge on 2025/06/29.
//

import SwiftUI

struct ScoreLibraryView: View {
    @StateObject private var viewModel = ScoreLibraryViewModel()

    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(viewModel.scores) { score in
                        ScoreThumbnailView(score: score)
                    }
                }
                .padding()
            }
            .navigationTitle("My Scores")
            .onAppear {
                viewModel.loadScores()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreLibraryView()
    }
}
