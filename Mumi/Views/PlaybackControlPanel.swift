import SwiftUI

struct PlaybackControlPanel: View {
    let score: Score
    @Binding var isShowing: Bool
    @State private var panelOffset: CGFloat = UIScreen.main.bounds.height // Start off-screen
    @State private var isPlaying = false
    @State private var bpm: Int? = nil
    @State private var tempo: Double = 120
    @State private var showToast = false

    private var buttonSize: CGFloat {
        UIDevice.current.userInterfaceIdiom == .pad ? 60 : 40
    }

    var body: some View {
        VStack {
            Spacer() // Pushes content to the bottom

            VStack {
                // Drag handle
                Rectangle()
                    .frame(width: 40, height: 5)
                    .cornerRadius(2.5)
                    .foregroundColor(.gray)
                    .padding(.vertical, 16)
                    .accessibilityIdentifier(AccessibilityIdentifiers.playbackControlPanelDragHandle)
                
                HStack {
                    Text(score.url.deletingPathExtension().lastPathComponent)
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                        .accessibilityIdentifier(AccessibilityIdentifiers.playbackControlPanelScoreTitle)
                    Spacer()
                    Text(bpm == nil ? "- BPM" : "\(bpm ?? 0) BPM")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                        .accessibilityIdentifier(AccessibilityIdentifiers.playbackControlPanelBpmText)
                }
                .padding(.horizontal)
                .padding(.bottom, 16)

                // Tempo Slider
                CustomTempoSlider(value: $tempo, range: 40...200, onEditingChanged: { editing in
                    if editing {
                        bpm = Int(tempo)
                    }
                })
                .padding(.horizontal)
                .padding(.bottom, 32)
                .onChange(of: tempo) {
                    if bpm != nil {
                        bpm = Int(tempo)
                    }
                }
                .accessibilityIdentifier(AccessibilityIdentifiers.playbackControlPanelTempoSlider)

                // Play/Pause Button
                Button(action: {
                    if bpm == nil {
                        showToast = true
                    } else {
                        isPlaying.toggle()
                    }
                }) {
                    Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                        .font(.system(size: buttonSize))
                        .frame(width: buttonSize, height: buttonSize)
                        .foregroundColor(bpm == nil ? .gray : .white)
                }
                .padding(.bottom, 32)
                .accessibilityIdentifier(AccessibilityIdentifiers.playbackControlPanelPlayButton)
            }
            .padding()
            .background(
                Color.black.opacity(0.7) // Transparent background
                    .cornerRadius(20)
            )
            .offset(y: panelOffset)
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        panelOffset = max(0, gesture.translation.height) // Only allow dragging down
                    }
                    .onEnded { gesture in
                        if gesture.translation.height > 100 { // If dragged down significantly, hide
                            isShowing = false
                        } else {
                            panelOffset = 0 // Snap back to fully visible
                        }
                    }
            )
            .onChange(of: isShowing) {
                withAnimation(.interactiveSpring()) {
                    panelOffset = isShowing ? 0 : UIScreen.main.bounds.height
                }
            }
            .accessibilityIdentifier(AccessibilityIdentifiers.playbackControlPanel)
        }
        .edgesIgnoringSafeArea(.bottom)
        .overlay {
            if showToast {
                ToastView(message: "Please set the tempo using the slider.", isShowing: $showToast)
                    .accessibilityIdentifier(AccessibilityIdentifiers.playbackControlToastView)
            }
        }
    }
}

