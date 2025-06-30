
import SwiftUI

struct ScoreDetailHeaderView: View {
    var onBack: () -> Void

    var body: some View {
        HStack {
            Button(action: onBack) {
                Image(systemName: "chevron.backward")
                    .font(.title2)
                    .foregroundColor(Color.Theme.accent)
            }
            Spacer()
        }
        .padding()
        .background(Color.Theme.surface.edgesIgnoringSafeArea(.top))
    }
}
