# BLOC 2026 - Learn Clean Architecture

A Flutter training project demonstrating **Clean Architecture**, **BLoC pattern**, and industry best practices for building production-ready mobile applications.

---

## 📱 What This App Does

1.  **Splash Screen** - Shows app logo with animations, checks if user is logged in.
2.  **Login Screen** - User enters username/password to authenticate.
3.  **Dashboard** - Displays products from API with pagination, pull-to-refresh, and logout.

---

## � Environments & Flavors

We use **Flavors** (different environments) to manage the app lifecycle from development to production effectively.

### Why do we use Flavors?

1.  **Safety**: We don't want to test new features on the "Production" database where real user data lives. We use "Dev" or "Staging" for that.
2.  **configuration**: Each environment needs different settings (e.g., API Base URL, App Name, Icon).
    *   **Dev**: Uses test APIs, shows debug logs.
    *   **Staging**: A mirror of production for final testing.
    *   **Prod**: The live app for real users.

### How to Run (Command Line)

| Env | Entry Point | Command |
|-----|------------|---------|
| **Dev** | `lib/main/main_dev.dart` | `flutter run -t lib/main/main_dev.dart` |
| **Staging** | `lib/main/main_staging.dart` | `flutter run -t lib/main/main_staging.dart` |
| **Prod** | `lib/main.dart` | `flutter run` |

### How to Set Up in Android Studio

To run different flavors easily in Android Studio, create **Run Configurations**:

1.  Click the **Run Configuration** dropdown (next to the Play button in the top toolbar).
2.  Select **Edit Configurations...**.
3.  Click the **+** (Plus) icon and select **Flutter**.
4.  **Create Dev Config**:
    *   **Name**: `main_dev`
    *   **Dart entrypoint**: Browse and select `lib/main/main_dev.dart`
5.  **Create Staging Config**:
    *   **Name**: `main_staging`
    *   **Dart entrypoint**: Browse and select `lib/main/main_staging.dart`
6.  **Create Prod Config**:
    *   **Name**: `main`
    *   **Dart entrypoint**: Browse and select `lib/main.dart`
7.  Click **Apply** and **OK**.

Now you can simply switch between `main_dev`, `main_staging`, and `main` from the dropdown and hit Play! ▶️

---

## �️ Project Architecture (Clean Architecture)

This project follows **Clean Architecture**. Each feature (e.g., `login`, `dashboard`) is split into **3 main layers** inside its folder.

**Folder Structure Order:**

### 1. 📂 Data (`lib/features/feature_name/data/`)
*The "Hardware" of the feature. Handles raw data.*

*   **Datasources** (`datasources/`): Files that actually call the API (e.g., `Dio` requests) or Local DB.
*   **Models** (`models/`): Dart classes that match the API JSON response exactly (using `fromJson`).
*   **Repositories Implementation** (`repositories/`): The implementation of the Domain Repository. It decides *where* to get data (API vs Cache).

### 2. 📂 Domain (`lib/features/feature_name/domain/`)
*The "Brain" of the feature. Pure business logic, no UI code.*

*   **Repositories** (`repositories/`): Abstract interfaces (contracts) defining *what* data is needed, but not *how* to get it.
*   **UseCases** (`usecases/`): Single-purpose classes that do ONE thing (e.g., `LoginUseCase`, `GetProductsUseCase`). The UI calls these.

### 3. 📂 Presentation (`lib/features/feature_name/presentation/`)
*The "Face" of the feature. What the user sees.*

*   **Cubit/BLoC** (`cubit/`): State management. Calls UseCases and updates the State.
*   **Pages** (`pages/`): Flutter Widgets (UI). They listen to the Cubit state and rebuild.
*   **Widgets** (`widgets/`): Reusable widgets specific to this feature.

---

## 📦 Dependencies (`pubspec.yaml`)

This file manages all third-party libraries and assets.

### Key Packages
| Package | Purpose |
|---------|---------|
| **State Management** |
| `flutter_bloc` | Helps manage state using BLoC/Cubit pattern. |
| `bloc` | Core BLoC logic. |
| `equatable` | Helps compare objects (useful for identifying if State has changed). |
| `get_it` | Service Locator for Dependency Injection (accessing objects anywhere). |
| **Networking** |
| `dio` | Powerful HTTP client for making API calls. |
| `flutter_pretty_dio_logger` | Prints readable API logs to the console for debugging. |
| `connectivity_plus` | Checks if the device has internet connection. |
| **Navigation & UI** |
| `go_router` | Handles screen navigation and URLs (e.g., `/home`). |
| `get` | used here mainly for Translation (`.tr`) and Utils. |
| `toastification` | Shows nice toast messages/notifications in the app. |
| `flutter_svg` | Allows rendering SVG (vector) icons. |
| `cupertino_icons` | iOS style icons. |
| `cached_network_image` | Loads and caches internet images (so they load faster next time). |
| **Storage & Utils** |
| `hive_flutter` | Fast local NoSQL database (storage) for the app. |
| `intl` | Date and number formatting. |

### Pubspec File Explained

Besides `dependencies`, the `pubspec.yaml` contains:

1.  **Environment**: `sdk: ^3.10.3` (Requires Dart SDK version 3.10.3 or higher).
2.  **Dev Dependencies**: Tools only for developers, not in the final app.
    *   `flutter_launcher_icons`: Generates app icons for Android/iOS.
    *   `rename_app`: Updates the app bundle ID and name.
3.  **Flutter Section**:
    *   **Assets**: Lists folders (`assets/images/`, `assets/language/`) so Flutter knows to include them.
    *   **Fonts**: Registers custom fonts (e.g., `OpenSans`) for use in `TextStyle`.
















###