# Logiks Solutions - Flutter CRUD Application

A Flutter CRUD application built for the Logiks Solutions technical task.
The app communicates with the public `restful-api.dev` API and demonstrates a clean project structure, BLoC state management, dependency injection, and user-friendly error handling.

## Task Requirements

The application implements the required functionality:

* Displays a list of objects from the API.
* Shows each object's ID and name on the main screen.
* Opens a details screen when an object is selected.
* Displays all available information about the selected object.

The optional functionality is also implemented:

* Create a new object.
* Fully edit an object using PUT.
* Partially update an object using PATCH.
* Delete an object.
* Add or remove dynamic custom data fields.

## Architecture

The project follows a Clean Architecture-inspired structure, separated into three main layers:

### Domain Layer

Located in:

```text
features/objects/domain/
```

Contains the core business definitions of the feature:

* `MyObjectEntity`
* Repository contract
* Use cases for get, create, update, partial update, and delete operations

This layer is independent from Flutter UI and API implementation details.

### Data Layer

Located in:

```text
features/objects/data/
```

Responsible for communication with the remote API.

It contains:

* API models
* Remote datasource contract and implementation
* Repository implementation

The data layer uses `Dio` for HTTP requests and maps API responses into domain entities.

### Presentation Layer

Located in:

```text
features/objects/presentation/
```

Responsible for UI and state management.

It contains:

* Screens
* Widgets
* BLoCs
* Events
* States

The UI communicates with BLoCs, and BLoCs call domain use cases instead of directly accessing API logic.

## Tech Stack

* **Flutter**
* **Dart**
* **flutter_bloc** for state management
* **get_it** for dependency injection
* **dio** for networking
* **equatable** for value comparison
* **flutter_test**, **bloc_test**, and **mocktail** for testing

## Features

### Main Screen

* Fetches and displays objects from the API.
* Shows object ID and name.
* Supports pull-to-refresh.
* Allows navigation to the details screen.

### Details Screen

* Displays all available object information.
* Shows dynamic custom data fields when available.
* Provides actions for editing, quick renaming, and deleting objects.

### Create / Edit Object

* Allows users to create new objects.
* Allows users to fully update existing objects.
* Supports dynamic key-value data fields.

### Partial Update

The app supports PATCH updates for selected fields.

For example, quick rename sends only the updated `name` field instead of replacing the full object.

### Delete

Users can delete objects that were created through the API.

## API Limitation

The public `restful-api.dev` API includes predefined seed objects, such as objects with IDs from `1` to `13`.

These seed objects are read-only for update and delete operations.
Trying to update or delete them may return:

```text
405 Method Not Allowed
```

This is expected behavior from the API, not an application bug.

The app handles this case with a user-friendly message:

```text
Seed objects are read-only. Try editing a created object.
```

## How to Test Full CRUD

To test create, update, patch, and delete correctly:

1. Open the app.
2. Tap the floating action button to create a new object.
3. Add a name and optional custom data fields.
4. Submit the form.
5. Open the newly created object.
6. Test:

   * Quick Rename using PATCH
   * Full Edit using PUT
   * Delete

Seed objects from the API should be used mainly for list and details viewing.

## Getting Started

### Prerequisites

Make sure Flutter is installed:

```bash
flutter --version
```

### Installation

Clone the repository:

```bash
git clone <your-repo-url>
```

Navigate to the project folder:

```bash
cd <project-folder>
```

Install dependencies:

```bash
flutter pub get
```

Run the app:

```bash
flutter run
```

Run on Chrome:

```bash
flutter run -d chrome
```

## Testing

Run tests with:

```bash
flutter test
```

The project includes tests for BLoC behavior and state emissions using mocked dependencies.

## Project Structure

```text
lib/
  core/
    di/
    error/
    network/

  features/
    objects/
      data/
        datasources/
        models/
        repositories/

      domain/
        entities/
        repositories/
        usecases/

      presentation/
        bloc/
        pages/
        widgets/
```

## Notes for Reviewers

This project focuses on clean separation of responsibilities, readable code, and predictable state management.

The app intentionally handles the public API limitation around read-only seed objects and allows full CRUD testing on newly created objects.
