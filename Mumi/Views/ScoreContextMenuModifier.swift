//
//  ScoreContextMenuModifier.swift
//  Mumi
//
//  Created by stinge on 2025/07/06.
//

import SwiftUI

struct ScoreContextMenuModifier: ViewModifier {
    let score: Score
    @ObservedObject var viewModel: ScoreLibraryViewModel
    @Binding var scoreToRename: Score?
    @Binding var isRenameSheetPresented: Bool

    func body(content: Content) -> some View {
        content
            .contextMenu {
                Button {
                    scoreToRename = score
                    isRenameSheetPresented = true
                } label: {
                    Label(
                        "Rename",
                        systemImage: "pencil"
                    )
                    .accessibilityIdentifier(AccessibilityIdentifiers.scoreThumbnailMenuButtonRenameLabel)
                }
                Button(role: .destructive) {
                    viewModel.deleteScore(score)
                } label: {
                    Label(
                        "Delete",
                        systemImage: "trash"
                    )
                    .accessibilityIdentifier(AccessibilityIdentifiers.scoreThumbnailMenuButtonDeleteLabel)
                }
            }
    }
}

extension View {
    func scoreContextMenu(
        score: Score,
        viewModel: ScoreLibraryViewModel,
        scoreToRename: Binding<Score?>,
        isRenameSheetPresented: Binding<Bool>
    ) -> some View {
        self.modifier(
            ScoreContextMenuModifier(
                score: score,
                viewModel: viewModel,
                scoreToRename: scoreToRename,
                isRenameSheetPresented: isRenameSheetPresented
            )
        )
    }
}
