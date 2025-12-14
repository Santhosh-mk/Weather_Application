🌦️ Mobile Weather Forecast Application (Flutter)
📘 Project Overview

This project is a Mobile Weather Forecast Application developed using Flutter as part of the BSc (Hons) Computing (Top-Up) coursework at Kingston University (via ESoft). The application demonstrates the use of Clean Architecture, Riverpod state management, and OpenWeatherMap API integration to deliver real-time and forecast weather data through a modern and user-friendly mobile interface.

The app focuses on strong software engineering principles including layered architecture, API consumption, local storage, responsive UI design, and proper error handling, without requiring user authentication.

✨ Key Features

🌍 Search weather by city name
🌡️ Display current temperature, humidity, wind speed, sunrise & sunset
📅 5-day weather forecast (based on OpenWeatherMap API)
⭐ Add and manage favourite cities
💾 Persistent local storage using SharedPreferences
⚙️ Settings screen for app preferences
🧭 Bottom navigation with multiple functional screens
🎨 Material Design–based UI with icons and gradients
🔁 Reactive UI updates using Riverpod

🏗️ Architecture

The application follows Clean Architecture, separating the codebase into three main layers:
Presentation Layer – UI screens and Riverpod providers
Domain Layer – Business logic, entities, and abstract repositories
Data Layer – API services, repository implementations, and data parsing
This structure improves maintainability, testability, and scalability.

🔧 Technologies & Libraries Used

Flutter & Dart
Riverpod – State management
OpenWeatherMap API – Weather data
http – API communication
SharedPreferences – Local persistent storage
weather_icons – Weather-based icons
Material Design – UI components

🧪 Testing

The application was tested using manual test cases covering:

API data fetching
Search functionality
Favourites management
State updates
Navigation flow
Error handling scenarios

🚀 How to Run the Project
git clone https://github.com/your-username/weather_application.git
cd weather_application
flutter pub get
flutter run

📦 Build APK
flutter build apk

📚 Academic Purpose
This project was developed for educational purposes only to demonstrate mobile application development skills, architecture design, API integration, state management, UI/UX design, and documentation practices.

👤 Author

Santhosh K2600128
BSc (Hons) Computing (Top-Up)
Kingston University / ESoft
