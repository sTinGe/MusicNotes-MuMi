# MuMi – Control Panel Screen (iOS UI Design)

Design a clean, modern mobile UI screen for an iOS app titled MuMi – 
a music sheet reader designed for Musicians.

Use following design principles/system:
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

The layout should have the following sections:

---

## 1. Status Bar (Top)

- **Style**: Standard iOS layout (top safe area)

---

## 2. Back Button

- **Style**: A Back button to back to main screen
- **Color**: primary color
- **Background**: a transparant background, only a back button appeared

---

## 3. Detail View

- **View**: Occupied the screen. Use the screen if top/bottom's components are hidden
- **Padding**: spacing between Back Button should around 8~12px
- **Progress Bar**: Comparing with a scrolling bar on the right side, provide a top progress bar to display the pdf's progress. 
    - Progress Percentage text: display the pdf's scroll percentage. If the PDF only has one page, the progress bar should 100%
    - Layout: Progress Bar should be horizontal stack. the Progress Bar fills the remaining space of Progress Percentage text.
- **PDF detail**: PDF content should use remaining screen as much as possible. With a little bit padding (30px)

---

## 4. Playback Control Panel

- **Style**: A transparent panel view which can be dragged.
- **Color**: primary color
- **Background**: a transparant background, only a back button appeared
- **Title**: the title is the pdf's title
- **Tempo Slider**: A Slider to control the BPM of the music sheet. User can drag the slide to adjust the BPM. the range is 40~200.
- **Control Pannel**: a horizontal view composed by play button which in in the center. In this pannel, play button's right is a text to display the BPM. The default is -.


## 4. Bottom Navigation Bar

- **Padding**: Bottom safe area included
