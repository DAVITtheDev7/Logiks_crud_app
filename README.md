# Logiks Solutions - Flutter CRUD Application

A Flutter CRUD application built for the Logiks Solutions technical task.

The app uses the public `restful-api.dev` API and demonstrates a clean project structure, BLoC state management, dependency injection, Dio networking, and user-friendly error handling.

## Task Requirements

Implemented required features:

* Display a list of objects retrieved from the API.
* Show each object's ID and name.
* Navigate to a details screen when an object is selected.
* Display all available information about the selected object.

Implemented optional features:

* Create a new object.
* Fully update an object using PUT.
* Partially update an object using PATCH.
* Delete an object.
* Add dynamic custom data fields when creating or editing an object.

## Architecture

The project follows a Clean Architecture-inspired structure with three main layers.

### Domain Layer

Located in:

```text
features/objects/domain/
```

Contains:

* Entity
* Repository contract
* Use cases

This layer contains the core business rules and does not depend on Flutter UI, Dio, or API implementation details.

### Data Layer

Located in:

```text
features/objects/data/
```

Contains:

* API model
* Remote datasource contract
* Remote datasource implementation
* Repository implementation

This layer is responsible for API communication and JSON mapping.

### Presentation Layer

Located in:

```text
features/objects/presentation/
```

Contains:

* Screens
* Widgets
* BLoCs
* Events
* States

The UI communicates with BLoCs, and BLoCs execute domain use cases.

## Tech Stack

* Flutter
* Dart
* flutter_bloc
* get_it
* dio
* equatable
* flutter_test
* bloc_test
* mocktail

## Features

### Main Screen

* Loads and displays objects from the API.
* Shows object ID and name.
* Supports pull-to-refresh.
* Opens the details screen when an object is tapped.

### Details Screen

* Displays selected object information.
* Shows object ID, name, and optional custom data.
* Provides actions for quick rename, full edit, and delete.

### Create / Edit Object

* Allows creating a new object.
* Allows fully updating an existing object.
* Supports dynamic key-value data fields.
* Automatically parses values into basic JSON types such as boolean, number, and string.

### Partial Update

The app supports PATCH updates.

For example, quick rename updates only the top-level `name` field without replacing the full object.

### Delete

Objects created through the API can be deleted from the app.

## API Limitation

The public `restful-api.dev` API includes predefined seed objects, such as objects with IDs from `1` to `13`.

These seed objects are read-only for update and delete operations.
Trying to update or delete them can return:

```text
405 Method Not Allowed
```

This is expected API behavior, not an application bug.

The app handles this case and displays a user-friendly message:

```text
Seed objects are read-only.
```

## How to Test Full CRUD

To properly test create, update, patch, and delete:

1. Open the app.
2. Tap the floating action button to create a new object.
3. Enter a name and optional custom data fields.
4. Submit the form.
5. Open the newly created object.
6. Test:

   * Quick Rename using PATCH
   * Full Edit using PUT
   * Delete

Seed objects should mainly be used for viewing list and details data.

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
    errors/
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
        models/
        screens/
        widgets/
```

## Notes for Reviewers

This project focuses on:

* Clean separation of responsibilities
* Readable and maintainable code
* Predictable state management with BLoC
* Proper API abstraction through repository and datasource layers
* Graceful handling of public API limitations
