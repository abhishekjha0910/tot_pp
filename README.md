TOT App 🐾
A Flutter app that lets users explore dog breeds, view detailed information, save favorites, and locate dogs using Google Maps.

**Overview :-** 
* This app fetches dog data from a public API, displays it in a clean dashboard, and allows users to:
* 
* Browse dogs with images and breed details
* 
* Search for dogs by name
* 
* Add/remove dogs to/from favorites
* 
* View detailed information about each dog
* 
* Open the dog's location in Google Maps
* 
* Use a swipe gesture to add dogs to favorites

**Features :-** 
* Dog Dashboard: Displays a scrollable list of dogs fetched from an API.
* 
* Search Functionality: Filter dogs by name in real time.
* 
* Favorites Management: Save favorite dogs and view them in a dedicated page.
* 
* Dog Details Page:
* 
* Shows breed group, life span, and bred-for purpose.
* 
* Includes a swipe-to-add gesture for favorites.
* 
* Location Integration: Open the dog's current location in Google Maps.
* 
* Error Handling: Graceful handling of API failures and permission issues.

**How to Run**
Prerequisites
Flutter SDK (version 3.0 or newer)

Android Studio/iOS simulator or physical device

Internet connection (for API access)

Steps
Clone the repository:

bash
Copy
git clone https://github.com/abhishekjha0910/TOT_App
Install dependencies:

bash
Copy
flutter pub get
Run the app:

bash
Copy
flutter run
Code Structure
Main Files
**File Description**
* dashboard_page.dart	:- Main screen with dog list and search functionality
* dog_detail_page.dart :- Displays detailed dog info with swipe-to-favorite feature
* favorite_dogs_page.dart	:- Shows list of favorited dogs
* dogii.dart	:- Location integration screen with Google Maps functionality
* Key Components
* State Management: Uses basic setState for local state management

API Integration: Fetches data from https://freetestapi.com/api/v1/dogs

Navigation: Multi-screen flow with Navigator.push()

Permissions Handling: Location permission requests via geolocator

**Libraries Used** :- 
* Package	Purpose	Version
* http API data fetching	^1.1.0
* geolocator Location services integration	^10.0.0
* url_launcher Opening Google Maps in browser	^6.1.10
* flutter/material Core UI components	

**Architecture**


├── models/               # Data models (if added later)
├── services/             # API service classes (if added later)
├── widgets/              # Custom UI components (if added later)
├── dashboard_page.dart   # Main entry point
├── dog_detail_page.dart  # Dog details screen
├── favorite_dogs_page.dart # Favorites list
└── dogii.dart            # Location integration screen

Important Notes
The API endpoint (https://freetestapi.com/api/v1/dogs) must be active and accessible

Location features require physical device testing

Google Maps integration needs proper coordinate data in dog objects

**Future Improvements**
* Add proper data models for type safety
* 
* Implement state management (e.g., Provider/Riverpod)
* 
* Add image caching for network images
* 
* Include pull-to-refresh functionality
* 
* Add unit/widget tests
