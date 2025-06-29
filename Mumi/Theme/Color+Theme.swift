import SwiftUI

extension Color {
    struct Theme {
        static var background: Color { Color("Background") }
        static var text: Color { Color("Text") }
        static var accent: Color { Color("Accent") }
        static var primary: Color { Color("ThemePrimary") }
        static var onPrimary: Color { Color("OnPrimary") }
        static var surface: Color { Color("Surface") }
        static var onSurface: Color { Color("OnSurface") }
        static var secondary: Color { Color("ThemeSecondary") }
        static var onSecondary: Color { Color("OnSecondary") }
        static var error: Color { Color("Error") }
        static var onError: Color { Color("OnError") }
    }
}
