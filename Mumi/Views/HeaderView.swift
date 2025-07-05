import SwiftUI

struct HeaderView: View {
    @State private var searchText = ""
    var onAdd: () -> Void

    var body: some View {
        VStack {
            ZStack {
                Image("HeaderText")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 30)

                HStack {
                    Spacer()
                    Button(action: onAdd) {
                        Image(systemName: "plus")
                            .font(.largeTitle)
                            .foregroundColor(Color.Theme.accent)
                    }
                    .accessibilityIdentifier(AccessibilityIdentifiers.addButton)
                }
            }

            ZStack(alignment: .leading) {
                TextField("", text: $searchText, prompt: Text("Search...")
                    .foregroundColor(Color.Theme.text.opacity(0.5)))
                    .foregroundColor(Color.Theme.text)
                    .padding(.leading, 30)
                    .padding(10)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: .gray.opacity(0.4), radius: 3, x: 1, y: 2)

                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color.Theme.secondary)
                    .padding(.leading, 10)
            }
            .padding(.top, 10)
        }
    }
}
