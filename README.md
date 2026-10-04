# Pexels_App

A full-stack Flutter application that fetches, searches, and saves high-resolution images using the Pexels API. 

## Features
* **Infinite Scroll Feed:** Pinterest-style staggered masonry grid with automatic pagination.
* **Debounced Search:** Efficiently search the Pexels database without spamming API calls.
* **Local Persistence:** Save favorite photos locally across sessions using Shared Preferences.
* **Modern State Management:** Fully reactive architecture built on Riverpod 2.0 (Notifier/ConsumerWidget).
* **UI Polish:** Smooth fade-and-slide tile animations and interactive image viewing.
* **Theme Support:** Global Light, Dark, and System theme toggling.

## Setup Instructions
1. Clone the repository.
2. Run `flutter pub get` to install dependencies.
3. Obtain a free API key from [Pexels](https://www.pexels.com/api/).
4. To run this app, create a file named api_key.dart inside the lib/ directory and add: const String pexelsApiKey = 'YOUR_API_KEY';
5. Run the app: `flutter run`