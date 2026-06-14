# Logiks Solutions - Flutter CRUD Application

A production-ready Flutter application demonstrating Clean Architecture, predictable state management, and robust error handling. This project was built to interact with the public `restful-api.dev` endpoint.

## Architecture & Design Patterns

This project strictly adheres to **Clean Architecture** principles, dividing the codebase into three decoupled layers to maximize testability, scalability, and maintainability:

* **Domain Layer (`core/`, `features/objects/domain/`):** The pure Dart core of the application. Contains business entities (`MyObjectEntity`) and Use Cases. It is entirely independent of external packages, APIs, or Flutter UI components.

* **Data Layer (`features/objects/data/`):** Responsible for data retrieval and manipulation. It contains the Repository implementations, Remote Data Sources, and Data Models (`MyObjectModel`) for JSON serialization.

* **Presentation Layer (`features/objects/presentation/`):** Manages user interaction and state transformations utilizing the **BLoC (Business Logic Component)** pattern. UI logic is fully decoupled from design views via modularized, reusable widgets.

### Core Tech Stack

* **State Management:** `flutter_bloc` (Unidirectional data flow, reactive UI updates)
* **Dependency Injection:** `get_it` (Service locator pattern centralized in `core/di/`)
* **Network Client:** `dio` (Configured with custom interceptors for structured request/response logging)
* **Testing:** `flutter_test`, `bloc_test`, `mocktail` (Zero code-generation mocking)

## Key Features

* **Full CRUD Functionality:** Create, Read, Update (Full PUT & Quick PATCH), and Delete objects.
* **Dynamic Form Builder:** When creating or editing an object, users can dynamically add or remove custom Key/Value data fields, which are automatically parsed into typed JSON.
* **Optimistic UI & Smart Refreshes:** The app utilizes `RefreshIndicator` for pull-to-refresh on the main feed and `BlocListener` to instantly react to successful mutations without unnecessary full-page rebuilds.
* **Centralized Error Handling:** A dedicated `ErrorParser` translates raw server exceptions into user-friendly UI messages.

## Getting Started

### Prerequisites

* Flutter SDK (stable channel)
* Dart SDK
* Android Emulator / iOS Simulator, physical device, or Chrome (for web)

### Installation

1. Clone the repository:

```bash
git clone <your-repo-url>
```

2. Navigate to the project directory and fetch dependencies:

```bash
flutter pub get
```

3. Run the application:

**For Mobile (Emulator/Physical Device):**

```bash
flutter run
```

**For Web (Chrome):**

```bash
flutter run -d chrome
```

## Testing

This project includes unit tests for the presentation layer to verify state emissions and mock external dependencies.

To execute the test suite, run:

```bash
flutter test
```

## Important Note for Reviewers

**Read-Only Seed Data:** The `restful-api.dev` endpoint reserves objects with IDs `1` through `13` (e.g., Apple and Google devices) as static demonstration seeds. The server intentionally throws a `405 Method Not Allowed` exception if you attempt to `PUT`, `PATCH`, or `DELETE` these specific IDs.

### How to Test CRUD Operations

1. Tap the **Floating Action Button (+)** on the main list screen.
2. Create a completely new object (with optional dynamic data fields).
3. Once your custom object is generated and appears at the top of the list, you can seamlessly test the **Quick Rename (PATCH)**, **Full Edit (PUT)**, and **Delete** functionalities on it.

*Note: The application is programmed to explicitly catch the 405 error on seed objects and display a graceful UI warning rather than failing silently.*
