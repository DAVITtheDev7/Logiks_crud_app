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

* Create object request using POST.
* Full update request using PUT.
* Partial update request using PATCH.
* Delete request using DELETE.
* Dynamic custom data fields when creating or editing an object.
* Graceful handling of public API limitations.

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

* Allows submitting create requests using POST.
* Allows submitting full update requests using PUT.
* Supports dynamic key-value data fields.
* Automatically parses values into basic JSON types such as boolean, number, and string.

### Partial Update

The app supports PATCH requests.

For example, quick rename sends only the top-level `name` field instead of replacing the full object.

### Delete

The app supports DELETE requests and handles API errors gracefully when mutation is not allowed by the public API.

## API Limitation

The public `restful-api.dev` API is useful for testing CRUD-style HTTP requests, but it does not behave like a persistent production database.

The `GET /objects` endpoint returns predefined seed objects. After creating a new object with `POST`, the API returns the created object in the response, but the created object may not appear in the main `GET /objects` list after refresh.

Also, predefined seed objects, such as objects with IDs from `1` to `13`, are read-only for update and delete operations.

Trying to update or delete these objects can return:

```text
405 Method Not Allowed
```

This is expected API behavior, not an application bug.

The app handles this case and displays a user-friendly message:

```text
Seed objects are read-only.
```

## How to Test the App

1. Open the app.
2. View the list of objects returned by the API.
3. Tap an object to open its details screen.
4. Use the floating action button to submit a create request.
5. Use the details screen actions to test quick rename, full edit, and delete behavior.
6. If the selected object is a seed object, the API may reject update or delete requests with `405 Method Not Allowed`.
7. The app will show a user-friendly error message instead of failing silently.

Seed objects should mainly be used for list and details viewing. Mutation requests are implemented in the app, but the public API may reject or not persist changes depending on the selected object.

## Getting Started

### Prerequisites

Make sure Flutter is installed:

```bash
flutter --version
```

### Installation

Clone the repository:

```bash
git clone https://github.com/DAVITtheDev7/Logiks_crud_app
```

Navigate to the project folder:

```bash
cd <Logiks_crud_app>
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
