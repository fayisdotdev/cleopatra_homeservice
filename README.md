# Cleopatra Homecare

A Flutter application for booking home cleaning services. Users can select **Standard Cleaning**, **Deep Cleaning**, and **Add-On services**, preview their selections, and confirm bookings, which are stored locally for future reference.

---

## Features

- Browse a list of cleaning services grouped by category (Standard, Deep Cleaning, Add-Ons).  
- Select multiple services at once with an interactive UI.  
- View selected services in a **Confirmation Screen** with total cost calculation and a **Satisfaction Guarantee** message.  
- Save bookings locally using `GetStorage` for easy retrieval later.  
- View all past bookings in a **My Services** history screen.  
- Dynamic UI with animated selection indicators and color changes on selection.  
- Automatically clears selected services after booking.  
- Snackbars and debug logging for feedback and testing.  
- Built with **Flutter** and **GetX** for state management.  

---

## Getting Started

### Prerequisites

- Flutter SDK >= 3.x  
- Dart >= 3.x  
- Android Studio or VS Code  
- An emulator or physical device  

### Installation

1. Clone the repository:  
```bash
git clone https://github.com/fayisdotdev/cleopatra_homecare.git
cd cleopatra_homecare
Install dependencies:
$ flutter pub get

Run the app:
$ flutter run
```
### Folder Structure
lib/controllers/ – GetX controllers for services and bookings.

lib/models/ – Data models (Service, Booking).

lib/screens/ – UI screens (HomeScreen, ConfirmationScreen, MyServicesScreen).

android/ & ios/ – Platform-specific configuration.

### Notes 
ServiceController: Manages services, selection, and calculates total cost.

ConfirmationController: Saves bookings locally using GetStorage and provides methods to retrieve and clear bookings.

Animated & modern UI: Updated HomeScreen to show services in cards with smooth animations.

Booking Confirmation: Includes snackbars, debug prints, and automatic navigation back to HomeScreen.

State Management: Fully reactive using GetX.
### Extras Added
My Services Screen: Lets users view all previous bookings. 

Local Persistence: Bookings are stored locally for quick preview next time.

Error Handling & Debug: Added print statements and snackbar notifications for confirmation.

Satisfaction Guarantee: Shows a friendly message ensuring customer happiness.

### Resources

#### [Flutter Documentation](https://docs.flutter.dev/)

#### [GetX Package](https://pub.dev/packages/get)

#### [GetStorage Package](https://pub.dev/packages/get)
