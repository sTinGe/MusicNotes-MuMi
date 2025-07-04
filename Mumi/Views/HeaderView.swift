import SwiftUI

struct HeaderView: View {
    var onAdd: () -> Void

    var body: some View {
        HStack {
//            Image(uiImage: UIImage(named: "header_text") ?? UIImage())
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
