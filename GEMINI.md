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
- **Target Simulator:** `iPhone 15 Pro (Latest iOS)`

**To build from the command line:**
```bash
xcodebuild build -workspace Mumi.xcworkspace -scheme Mumi -destination 'platform=iOS Simulator,name=iPhone 15 Pro'
```

**To run from the command line:**
*Instructions for running via CLI, if applicable.*

## 5. Dependencies

- **Installation:** Dependencies are managed exclusively through the Swift Package Manager (SPM) and are resolved automatically by Xcode.

## 6. Testing

- **Unit Tests Location:** `MumiTests/`
- **UI Tests Location:** `MumiUITests/`
- **Test Scheme:** `MumiTests`

**To run tests from the command line:**
```bash
xcodebuild test -workspace Mumi.xcworkspace -scheme Mumi -destination 'platform=iOS Simulator,name=iPhone 15 Pro'
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
