# Mumi App Specification

This document outlines the features and functionality of the Mumi automatic music score scrolling application.

## 1. Core Features

### 1.1. Score Display

- **Rendering:** Scores will be displayed with continuous vertical scrolling to ensure a smooth, uninterrupted reading experience for the musician.
- **Orientation:** The app will support both portrait (vertical) and landscape (horizontal) device orientations. The score layout will adapt to maximize readability in each orientation.

### 1.2. Playback Controls

- **BPM Input:** The user must input the desired Beats Per Minute (BPM) before starting the scroll.
- **Play/Pause Button:** 
    - The "Play" button will be disabled until a BPM value is set by the user.
    - Toggling this button will start or pause the automatic scrolling.
- **Stop Button:** This button will stop the scrolling and reset the view to the beginning of the score.
- **Tempo Display:** The currently set BPM will always be visible on the screen. A default or initial BPM value may be displayed on startup.

### 1.3. Tempo Setting

- **Combined Input:** The app will provide two methods for setting the tempo, which will be synchronized:
    1.  **Numeric Input:** A text field allowing the user to directly type in a precise BPM value.
    2.  **Tap-to-Tempo:** A dedicated button that the user can tap multiple times. The app will calculate the average time between taps to set the BPM.

### 1.4. Scrolling Behavior

- **Speed Calculation:** The scrolling speed will be determined by two user-defined parameters:
    1.  **BPM (Beats Per Minute):** The tempo of the piece.
    2.  **Beats per Screen:** A user-configurable setting that defines how many beats should pass for the content to scroll by one full screen height. This allows adjustment for musical density.
- **Formula:** The time (in seconds) to scroll one screen height will be calculated as: `(Beats per Screen / BPM) * 60`.

## 2. Score Management

### 2.1. Importing Scores

- **Multiple Import Options:** Users will be able to add PDF scores to their library through several standard iOS methods:
    1.  **Files App Integration:** Users can directly browse and import scores from the iOS Files app.
    2.  **Share Sheet ("Open In..."):** The app will register as a target for PDF files, allowing users to send scores from other apps (e.g., Mail, Safari, cloud storage) to Mumi.
    3.  **iCloud Drive Sync:** The app will create and monitor a dedicated "Mumi" folder in the user's iCloud Drive. Any PDFs placed in this folder will be automatically added to the app's library.

### 2.2. Score Library

- **Layout:** The user's collection of scores will be displayed in a grid view.
- **Previews:** Each item in the grid will be a thumbnail preview generated from the first page of the PDF score. This allows for quick visual recognition.
- **Labels:** The filename of the score will be displayed beneath each thumbnail.

### 2.3. Deleting Scores

- **Gesture:** Users can initiate a deletion by performing a long-press gesture on any score thumbnail in the library view.
- **Confirmation:** Upon long-pressing, a context menu will appear with a "Delete" option. Selecting "Delete" will trigger a system confirmation alert to prevent accidental removal of the score.