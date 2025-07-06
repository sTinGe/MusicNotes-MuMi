import SwiftUI

struct ScoreDetailHeaderView: View {
    var onBack: () -> Void
    @Binding var progress: CGFloat

    var body: some View {
        VStack {
            HStack {
                Button(action: onBack) {
                    Image(systemName: "arrow.backward")
                        .font(.largeTitle)
                        .foregroundColor(Color.Theme.accent)
                }
                .padding(.leading, 8)
                ProgressBarView(progress: progress)
                    .padding(.horizontal, 4)
                    .padding(.trailing, 8)
//                TextField("", value: $progress, formatter: NumberFormatter())
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .keyboardType(.decimalPad)
//                    .frame(width: 50)
            }
        }
        .padding(8)
        .background(Color.Theme.surface.edgesIgnoringSafeArea(.top))
    }
}
