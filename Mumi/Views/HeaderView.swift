import SwiftUI

struct HeaderView: View {
    var onAdd: () -> Void

    var body: some View {
        HStack {
            Text("Mumi")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color.Theme.text)
            Spacer()
            Button(action: onAdd) {
                Image(systemName: "plus")
                    .font(.largeTitle)
                    .foregroundColor(Color.Theme.accent)
            }
        }
        .padding()
    }
}
