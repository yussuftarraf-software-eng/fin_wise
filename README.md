# FinWise

A personal finance app built with Flutter that helps you track your monthly expenses, categorize spending, and visualize where your money goes through analytics and charts.

> **Status:** 🚧 Early work in progress — core screens (splash, launch, sign in) are implemented; expense tracking, analytics, and Firebase authentication are actively being built.

---

## Overview

FinWise is designed to give people a simple, clear way to log daily expenses and understand their spending habits over time — without needing a spreadsheet. The long-term goal is a lightweight, portfolio-quality app demonstrating clean Flutter architecture, reusable UI components, and thoughtful UX for everyday financial tracking.

## Features

- **Expense Tracking** — Add, view, and categorize expenses as you spend
- **Analytics & Charts** — Visual breakdowns of spending by category and time period
- **Authentication** — Secure sign in via Firebase Auth
- **Local Data Storage** — Expense data stored on-device

> Feature list will expand as development continues — see [Roadmap](#roadmap) below.

## Tech Stack

| Layer | Technology |
|---|---|
| Framework | [Flutter](https://flutter.dev) |
| Language | Dart |
| Authentication | Firebase Auth |
| Data Storage | Local storage (on-device) |
| Fonts | Google Fonts |

## Platforms

- ✅ Android
- ✅ iOS

## Screens Implemented So Far

- [x] Splash Screen
- [x] Launch Screen
- [x] Sign In Screen (UI complete — validation & Firebase auth pending)
- [ ] Sign Up Screen
- [ ] Home / Dashboard
- [ ] Add Expense
- [ ] Analytics / Charts
- [ ] Profile / Settings

## Project Structure

The app follows a component-driven structure with reusable custom widgets to keep the codebase consistent and maintainable:

```
lib/
├── constants/          # App-wide constants (colors, etc.)
├── presentation/
│   ├── custom_widgets/ # Reusable widgets (CustomButton, CustomTextField,
│   │                   # CustomMainAppContainer, CustomText, etc.)
│   └── screens/        # App screens
├── routes/              # Centralized app routing
└── main.dart
```

Key design decisions:
- **Centralized colors** — all app colors are defined in a single `MyColors` class rather than scattered across widgets
- **Reusable widgets** — buttons, text fields, containers, and text styles are built once and reused across screens for visual consistency
- **Centralized routing** — navigation paths are defined in one place rather than hardcoded per screen

## Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) installed
- A configured Firebase project (for authentication)

### Installation

```bash
# Clone the repository
git clone <repo-url>
cd finwise

# Install dependencies
flutter pub get

# Run the app
flutter run
```

### Firebase Setup

This project uses Firebase Authentication. To run it locally you'll need to:

1. Create a Firebase project at [console.firebase.google.com](https://console.firebase.google.com)
2. Add your Android/iOS app to the Firebase project
3. Download and add `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
4. Run `flutterfire configure` if using FlutterFire CLI

## Roadmap

- [ ] Complete text field validation across all forms
- [ ] Integrate Firebase Authentication for sign in / sign up
- [ ] Build expense entry and category system
- [ ] Implement analytics dashboard with charts
- [ ] Add budget limits and alerts
- [ ] Polish UI/UX across all screens
- [ ] Publish repository publicly as a portfolio piece

## License

This repository is currently **private**. It will be made public once the project reaches a more complete state, so it can be shared as a portfolio project.

## Author

Built by Tarraf as part of a journey toward becoming a Flutter developer.