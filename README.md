# Cleopatra Homecare

A Flutter application for booking home cleaning services. Users can select standard cleaning, deep cleaning, and add-on services, preview their selections, and confirm bookings, which are stored locally for future reference.

## Features

- Browse a list of cleaning services grouped by category (Standard, Deep Cleaning, Add-Ons).
- Select multiple services at once with an interactive UI.
- View selected services in a **Confirmation Screen** with total cost calculation.
- Save bookings locally using `GetStorage` for easy retrieval later.
- View all past bookings in a **My Services** history screen.
- Dynamic UI with animated selection indicators.
- Clear selected services automatically after booking.
- Snackbars and debug logging for feedback and testing.
- Fully built with **GetX** state management and **Flutter**.

## Getting Started

### Prerequisites

- Flutter SDK >= 3.x
- Dart >= 3.x
- Android Studio or VS Code
- An emulator or physical device

### Installation

1. Clone the repository:

```bash
git clone https://github.com/yourusername/cleopatra_homecare.git
cd cleopatra_homecare
Install dependencies:

bash
Copy code
flutter pub get
Run the app:

bash
Copy code
flutter run
Folder Structure
lib/controllers/ – GetX controllers for services and bookings.

lib/models/ – Data models (Service, Booking).

lib/screens/ – UI screens (HomeScreen, ConfirmationScreen, MyServicesScreen).

lib/widgets/ – Reusable UI components (if any).

android/ & ios/ – Platform-specific configuration.

Notes / Extras Added
ServiceController: Manages services, selection, and calculates total cost.

ConfirmationController: Saves bookings locally using GetStorage and provides methods to retrieve and clear bookings.

Animated and modern UI: Updated HomeScreen to show services in cards with smooth animations and color changes on selection.

My Services Screen: Lets users view all previous bookings.

Booking confirmation: Includes snackbars, debug prints, and automatic navigation back to HomeScreen.

State management: Fully reactive using GetX.

Local persistence: Bookings are stored locally for quick preview next time.

Error handling and debug: Added print statements and snackbar notifications for confirmation.

Resources
Flutter Documentation

GetX Package

GetStorage Package
