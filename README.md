# Bike Rental App 

A Flutter-based mobile application designed for renting bikes, viewing rental stations, and managing subscriptions. This project was developed as part of an Advanced Mobile Development curriculum.

## Features

- **Interactive Map**: View real-time station locations and available bikes.
- **Bike Booking**: Seamlessly find and rent available bikes.
- **Subscription Management**: Purchase and manage bike rental passes.
- **User Profiles**: Track user rental history and active subscriptions.

## Tech Stack

- **Framework**: [Flutter](https://flutter.dev/)
- **State Management**: [Provider](https://pub.dev/packages/provider)
- **Backend / Database**: [Firebase](https://firebase.google.com/) (Realtime Database & Cloud Firestore)
- **Architecture**: MVVM (Model-View-ViewModel)

## Folder Structure

- `lib/data/` - Models, DTOs, and Repositories for Firebase and local mock data.
- `lib/ui/screens/` - Modular feature screens (Booking, Map, Pass Selection, Profile) with their respective ViewModels.
- `lib/ui/states/` - Global state models accessible across the application.
- `lib/ui/theme/` - Standardized app theming including light and dark modes.

## Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (Version >= 3.9.2)
- iOS Simulator or Android Emulator

### Installation & Configuration

1. **Clone the repository**
   ```bash
   git clone https://github.com/sonika-tang/Prebros_Bike_Rental.git
   cd Prebros_Bike_Rental
   ```

2. **Install Dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Environment Variables**
   This project uses `flutter_dotenv` to securely store backend URLs, keeping them out of source control.
   - Copy the sample environment file:
     ```bash
     cp .env.example .env
     ```
   - Open `.env` and fill in your Firebase Database URL (Without the `https://` prefix):
     ```env
     FIREBASE_DB_URL=your-firebase-url.asia-southeast1.firebasedatabase.app
     ```

### Running the Application

This project supports separate entry points for development and production:

- **Development Mode** (Uses `main_dev.dart` with mock repositories, great for UI testing):
  ```bash
  flutter run -t lib/main_dev.dart
  ```

- **Production Mode** (Uses `main.dart` with live Firebase repositories):
  ```bash
  flutter run -t lib/main.dart
  ```

## Architecture Notes

* **Dependency Injection**: `provider` is used in the main functions to inject repositories (e.g. `BikeRepositoryFirebase`) into the widget tree.
* **Views and ViewModels**: Each screen couples with a `_vm.dart` extension to manage UI logic away from the widget declarations.

---
*Created for Advanced Mobile Development Final Project.*
