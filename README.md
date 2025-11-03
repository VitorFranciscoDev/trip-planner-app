# 🧭 Trip Planner

A Flutter application for managing and organizing trips — plan routes, register stops, add participants, and generate a digital travel booklet.  
The project was developed to demonstrate clean architecture, code organization, and the use of modern Flutter libraries for data persistence, localization, and UI design.

---

## 🚀 Features

- ✈️ Create, view, edit, and delete trips  
- 👥 Register participants with names and photos  
- 🗺️ View trip routes and stops on Google Maps  
- 📍 Manage city stops, arrival/departure dates, and activities  
- 📷 Add photos and notes for each stop  
- 📄 Generate a travel memory booklet in PDF format  
- 🌍 Multi-language support (English, Portuguese, Spanish)  
- 🌓 Dark and light themes  
- 💾 Local data storage using SQLite  

---

## 🧩 Project Structure

```
lib/
├── entities/             # Core domain entities
├── infrastructure/
│ ├── database/           # Local database management
│ └── presentation/       # UI layer
│ ├── app/                # Global state, themes, localization, components
│ └── screens/            # Application screens and views
└── modules/              # Feature modules
├── user/                 # User feature (use case, repository, spec)
├── trip/                 # Trip feature (use case, repository, spec)
├── stop/                 # Stop feature (use case, repository, spec)
└── ...                   # Other modules as needed
```

---

## ⚙️ Requirements

- Flutter SDK  
- Android Studio or VS Code with Flutter extension  

---

## ▶️ Running the App

```
# Install dependencies
flutter pub get

# Run the application
flutter run
```

---

# 💬 About
Trip Planner is a cross-platform Flutter app designed for efficient trip management and record keeping.
It provides an intuitive interface, offline data handling, and multi-language support for global users.
