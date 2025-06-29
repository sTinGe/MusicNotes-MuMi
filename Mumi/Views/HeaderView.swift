import SwiftUI

struct HeaderView: View {
    var onAdd: () -> Void

    var body: some View {
        HStack {
            Text("My Scores")
                .font(.largeTitle)
                .fontWeight(.bold)
            Spacer()
            Button(action: onAdd) {
                Image(systemName: "plus")
                    .font(.largeTitle)
            }
        }
        .padding()
    }
}
