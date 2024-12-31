# Tic & Tomate

## Overview  
The **Tic & Tomate Pomodoro Timer** is a minimalist iOS application designed to enhance productivity using the Pomodoro technique. The app features a retro-inspired flip clock interface, haptic feedback, and a modern black/gray/white design that aligns with Apple’s clean and intuitive aesthetic.  

With a focus on simplicity, this app provides a distraction-free environment, customizable timers, and seamless transitions for the ultimate user experience.  

---

## Features  
- **Retro Flip Clock Design**: A beautifully animated flip clock interface to track work and break sessions.  
- **Customizable Timer Settings**: Adjust work durations, short breaks, long breaks, and repetition cycles.  
- **Haptic Feedback**: Subtle and satisfying haptic interactions for buttons and session transitions.  
- **Do Not Disturb Mode**: Automatically activates "Do Not Disturb" during work sessions for maximum focus.  
- **Orientation Support**: Adaptive layout for both vertical and horizontal orientations.  
- **Sound Alerts**: Play subtle audio notifications at the end of each session.  
- **Dark/Light Modes**: Sleek black, gray, and white color scheme with light and dark mode compatibility.  

---

## Tech Stack  
- **Language**: Swift (latest version).  
- **Frameworks**:  
  - SwiftUI for UI and animations.  
  - UIKit for advanced haptic feedback and animations.  
  - AVFoundation for sound management.  
  - UserNotifications for Do Not Disturb integration.  
- **Data Persistence**: UserDefaults for storing user preferences.  

---

## Folder Structure  
- **Models**: Handles core data and logic (e.g., `PomodoroTimer`, `TimerSettings`).  
- **ViewModels**: Acts as the binding layer between Views and Models.  
- **Views**: Custom SwiftUI components (e.g., Flip Clock, Timer Controls).  
- **Services**: Auxiliary services like Haptic Feedback and Sound Management.  
- **Utilities**: Helper functions and reusable tools.  
- **Resources**: Color palette, assets, and localization files.  

---

## Getting Started  

1. Clone the repository:  
  ```bash
   git clone https://github.com/your-username/flip-clock-pomodoro.git
   cd flip-clock-pomodoro
   ```

2. Open the project in Xcode:
  ```bash
  open FlipClockPomodoro.xcodeproj
  ```

3.	Run the app on a simulator or a connected iPhone.

## Roadmap
-	Add session statistics and progress tracking.
- Integrate with Apple Health for focus tracking.
- Provide customizable themes beyond the default color scheme.
- Explore widgets for quick access to the timer.

## License

This project is licensed under the MIT License. Feel free to use and modify it as needed.

## Contributions

Contributions are welcome! Please open an issue or submit a pull request to discuss any improvements or new features.