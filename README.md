# Currency Converter

## Overview

Currency Converter is a Flutter application designed to provide an easy and efficient way to convert currencies. This README file will guide you through setting up and running the project, and provide a brief explanation of the architectural choices made.

## Getting Started

### Prerequisites
- Flutter SDK
- Android Studio or VS Code with the Flutter extension

### Installation via code

#### Clone the repository

```bash
git clone https://github.com/MadukaNuwantha/Currency-Converter.git
cd currency-converter
```

#### Install dependencies
```bash
flutter pub get
```

#### Run the application
```bash
flutter run
```

### Installation via apk
- Locate the file named Currency Converter v1.0.0.apk in the root directory
- Transfer the APK file to an Android Device
- Open the file and follow the instructions to install the app
- Once installed, open the app from your app drawer

## Project Structure
The project follows a clean and organized architecture to ensure scalability and maintainability. Here's a brief explanation of the architecture
```bash
lib/
  dialogs/: Contains custom dialog widgets.
  models/: Contains data models.
  screens/: Contains the main screens of the application.
  services/: Contains services like API calls, data processing, etc.
  widgets/: Contains common reusable widgets.
  constants.dart: Contains constants used throughout the app.
  main.dart: The entry point of the application.
```

### Architecture Choice
The architecture used in this project is inspired by the MVVM (Model-View-ViewModel) pattern, which helps in separating the business logic from the UI. This separation makes the code more modular, testable, and maintainable

- Model: Represents the data layer. This includes the data models and data handling logic
- View: Represents the UI layer. This includes the screens and UI widgets
- ViewModel: Acts as a bridge between the Model and View layers. It handles the business logic and updates the UI based on the data changes in this case the services