# 🎬 Movie App

A high-performance, cross-platform movie exploration application built with
**Flutter**, following **Clean Architecture**
principles and modern development best practices.

## 🚀 Features

*   **User Authentication:** Secure Sign-In and Sign-Up powered by **Firebase Auth**.
*   **Movie Discovery:** Explore popular, top-rated, and upcoming movies.
*   **Advanced Search:** Real-time search functionality to find any movie instantly.
*   **Offline Wishlist:** Save your favorite movies locally using **Hive Database** for offline access.
*   **Responsive UI:** A beautiful, adaptive interface that works seamlessly on different screen sizes using a custom responsive system.
*   **Localization:** Support for multiple languages with easy translation management.
*   **Detailed View:** Get comprehensive info about movies.

## 🛠 Tech Stack & Architecture

This project is built with a focus on scalability and maintainability:

*   **Architecture:** Clean Architecture (Data, Domain, and Presentation layers).
*   **State Management:** Flutter Bloc / Cubit for predictable state flow.
*   **Dependency Injection:** `GetIt` & `Injectable` for modular and testable code.
*   **Networking:** Centralized `ApiManager` for robust API calls.
*   **Local Storage:** `Hive` for lightning-fast local data persistence.
*   **Backend:** `Firebase` (Authentication).
*   **Responsiveness:** Custom responsive utility for consistent UI across devices.

## 📂 Project Structure

```text
lib/
├── api/            # API management and endpoints
├── auth/           # Authentication UI and logic
├── core/           # Constants, themes, routes, and shared utilities
├── cubit/          # Global state management (Auth, Profile, Wishlist, etc.)
├── data/           # Data layer (Repositories & Local Data Sources)
├── di/             # Dependency Injection setup (GetIt/Injectable)
├── domain/         # Business logic (Entities & Use Cases)
├── home_layout/    # Main app navigation and tabs
├── model/          # Data models and response objects
├── onBoarding/     # Onboarding screens
└── widgets/        # Reusable UI components
```

## ⚙️ Getting Started

### Prerequisites
*   Flutter SDK (Stable channel)
*   A Firebase project (Configured via `firebase_options.dart`)

### Installation
1.  **Clone the repository:**
    ```bash
    git clone https://github.com/hassanomara842/movie_app.git
    ```
2.  **Install dependencies:**
    ```bash
    flutter pub get
    ```
3.  **Run code generation:**
    ```bash
    flutter pub run build_runner build --delete-conflicting-outputs
    ```
4.  **Launch the app:**
    ```bash
    flutter run
    ```

---
Developed with team❤️
