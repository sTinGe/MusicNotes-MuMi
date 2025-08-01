# Gemini Project Companion: iOS App

This document provides essential information for the Gemini agent to understand and assist with this iOS project.

## 1. Project Overview

This is an automatic music score scrolling app for iOS. It provides a hands-free way for musicians, particularly orchestral musicians, to read and play sheet music. The app will load PDF scores, allow tempo setting, and automatically scroll the music.

## 2. Technologies & Architecture

- **Language:** Swift
- **UI Framework:** SwiftUI
- **Architecture:** MVVM
- **Concurrency:** Async/Await
- **Package Manager:** Swift Package Manager

## 3. Project Structure

- **Workspace/Project File:** `path/to/Mumi.xcworkspace` or `path/to/Mumi.xcodeproj`
- **Source Code Root:** `path/to/source/`
- **Key Directories:**
    - `Mumi/Views`: (SwiftUI Views or UIViewController subclasses)
    - `Mumi/ViewModels`: (ObservableObjects or classes that prepare data for Views)
    - `Mumi/Models`: (Core data structures and domain models)
    - `Mumi/Services`: (Networking, data persistence, etc.)
    - `Mumi/Resources`: (Asset catalogs, storyboards, etc.)

## 4. Build & Run

- **Primary Scheme:** `Mumi`
- **Configuration:** `Debug`
- **Target Simulator:** `iPhone 16 Pro (Latest iOS)`

**To build from the command line:**
```bash
xcodebuild build -workspace Mumi.xcworkspace -scheme Mumi -destination 'platform=iOS Simulator,name=iPhone 16 Pro'
```

**To run from the command line:**
*Instructions for running via CLI, if applicable.*

## 5. Dependencies

- **Installation:** Dependencies are managed exclusively through the Swift Package Manager (SPM) and are resolved automatically by Xcode.

## 6. Testing

- **Unit Tests Location:** `MumiTests/`
- **UI Tests Location:** `MumiUITests/`
- **Test Scheme:** `MumiTests`
- **View Testing Library:** `ViewInspector`

**View Testing Convention:**
To ensure tests are robust and decoupled from UI details like button text or image names, we will use the following convention:
1.  Add a new `static let` constant for the identifier to the `AccessibilityIdentifiers.swift` file.
2.  Add the `.accessibilityIdentifier()` modifier to the view that needs to be found in a test, using the constant from the previous step.
3.  In the test, use `view.inspect().find(viewWithAccessibilityIdentifier: AccessibilityIdentifiers.yourIdentifier)` to locate the view.

**To run tests from the command line:**
```bash
xcodebuild test -workspace Mumi.xcworkspace -scheme Mumi -destination 'platform=iOS Simulator,name=iPhone 16 Pro'
```

## 7. Code Style & Linting

- **Linter:** SwiftLint
- **Formatting Conventions:** We follow the Ray Wenderlich style guide.

**To run the linter:**
```bash
swiftlint
```

## 8. Design & UI/UX Resources

- **Apple Human Interface Guidelines (HIG):** The primary guide for iOS design philosophy and best practices.
  - https://developer.apple.com/design/human-interface-guidelines/
- **SF Symbols:** The official library of icons for iOS apps.
  - https://developer.apple.com/sf-symbols/
- **SwiftUI Documentation:** Technical documentation for all UI components.
  - https://developer.apple.com/documentation/swiftui/

### Color System: "Ocean Depths"

| Role | Light Mode | Dark Mode |
| :--- | :--- | :--- |
| **Primary** | `#005A9C` | `#50A5FF` |
| **On Primary** | `#FFFFFF` | `#000000` |
| **Surface** | `#F0F4F8` | `#1A1D21` |
| **On Surface** | `#2C3E50` | `#D0D8E0` |
| **Background** | `#F0F4F8` | `#1A1D21` |
| **On Background**| `#2C3E50` | `#D0D8E0` |
| **Secondary** | `#5A7D9A` | `#A9C7E0` |
| **On Secondary**| `#FFFFFF` | `#000000` |
| **Error** | `#B00020` | `#FFB4AB` |
| **On Error** | `#FFFFFF` | `#69000F` |
