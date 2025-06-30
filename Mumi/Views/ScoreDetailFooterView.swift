
import SwiftUI

struct ScoreDetailFooterView: View {
    var onPlay: () -> Void
    var onStop: () -> Void
    
    @State private var tempo: Double = 120

    var body: some View {
        HStack {
            Button(action: onPlay) {
                Image(systemName: "play.fill")
                    .font(.title)
                    .foregroundColor(Color.Theme.accent)
            }
            
            Spacer()
            
            Button(action: onStop) {
                Image(systemName: "stop.fill")
                    .font(.title)
                    .foregroundColor(Color.Theme.accent)
            }
            
            Spacer()

            HStack {
                Image(systemName: "metronome")
                    .font(.title)
                    .foregroundColor(Color.Theme.text)
                Text("\(Int(tempo)) BPM")
                    .font(.body)
                    .foregroundColor(Color.Theme.text)
            }
        }
        .padding()
        .background(Color.Theme.surface.edgesIgnoringSafeArea(.bottom))
    }
}
