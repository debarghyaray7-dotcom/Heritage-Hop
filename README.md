# HeritageHop 🏛️

> **Explore India's Soul** — An AI-powered heritage travel app built with Flutter

HeritageHop is a mobile travel companion designed to help tourists discover India's rich cultural heritage, plan budget-friendly trips, and explore iconic destinations with the help of an integrated AI assistant.

---

## 📱 Screenshots

| Splash | Login | Home | City Explorer |
|--------|-------|------|---------------|
| *(Add screenshot)* | *(Add screenshot)* | *(Add screenshot)* | *(Add screenshot)* |

---

## ✨ Features

- **Explore Cities** — Curated heritage places, attractions, food spots, and hotels across Indian cities
- **AI Travel Assistant** — Powered by Gemini AI; get personalized trip advice, budget tips, and local recommendations
- **AI Trip Planner** — Generate day-by-day itineraries tailored to your budget and interests
- **Place Detail Pages** — Entry fees, timings, transport options, travel tips, gallery, and nearby suggestions
- **Favorites** — Save places you want to visit
- **Dark / Light Mode** — Full theme support with persistent preference
- **Smooth Animations** — Splash, page transitions, and card animations throughout

---

## 🏙️ Cities Available

| City | Status |
|------|--------|
| Kolkata | ✅ Active (10 places) |
| Jaipur | 🔜 Coming Soon |
| Delhi | 🔜 Coming Soon |
| Varanasi | 🔜 Coming Soon |

---

## 🛠️ Tech Stack

| Layer | Technology |
|-------|-----------|
| Framework | Flutter (Dart) |
| State Management | Riverpod |
| Navigation | GoRouter |
| AI Chat | Google Gemini API |
| Authentication | Firebase Auth + Google Sign-In |
| Theme Persistence | SharedPreferences |
| Font | Outfit (Google Fonts) |

---

## 📁 Project Structure

```
lib/
├── data/
│   └── tourism_data.dart        # All cities & places data
├── models/
│   └── tourism_models.dart      # TourismPlace, City, ChatMessage, TravelPlan
├── providers/
│   └── theme_provider.dart      # Riverpod theme state
├── routes/
│   └── app_router.dart          # GoRouter configuration
├── screens/
│   ├── auth/
│   │   ├── splash_screen.dart
│   │   ├── login_screen.dart
│   │   └── signup_screen.dart
│   ├── home/
│   │   └── home_screen.dart
│   ├── city/
│   │   └── city_screen.dart
│   ├── place/
│   │   └── place_detail_screen.dart
│   ├── chat/
│   │   └── chat_screen.dart
│   ├── planner/
│   │   └── planner_screen.dart
│   └── profile/
│       └── profile_screen.dart
├── services/
│   ├── auth_services.dart       # Firebase Auth service
│   └── gemini_services.dart     # Gemini API service
├── themes/
│   └── app_theme.dart           # Light & dark themes
└── utils/
    └── app_constants.dart       # Routes, keys, constants

assets/
├── fonts/
│   └── Outfit/
├── icons/
└── images/
    ├── logo.JPG
    ├── kolkata.jpg
    ├── jaipur.jpg
    ├── delhi.jpg
    ├── varanasi.jpg
    ├── victoria_memorial.jpg
    ├── howrah_bridge.jpg
    ├── college_street.jpg
    ├── dakshineswar.jpg
    ├── indian_museum.jpg
    ├── kalighat.png
    ├── science_city.jpg
    ├── sundarbans.jpg
    ├── eco_park.jpg
    └── new_market.jpg
```

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK `>=3.0.0`
- Dart SDK `>=3.0.0`
- A Google Gemini API key — [Get one here](https://makersuite.google.com/app/apikey)
- A Firebase project (for authentication) — [Firebase Console](https://console.firebase.google.com/)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/YOUR_USERNAME/heritagehop.git
   cd heritagehop
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Add your Gemini API key**

   Open `lib/services/gemini_services.dart` and replace:
   ```dart
   static const String _apiKey = 'YOUR_GEMINI_API_KEY_HERE';
   ```
   with your actual key.

4. **Set up Firebase** *(optional — app works without it in prototype mode)*

   - Create a Firebase project
   - Enable Email/Password and Google Sign-In authentication
   - Download `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
   - Place them in `android/app/` and `ios/Runner/` respectively

5. **Run the app**
   ```bash
   flutter run
   ```

> **Note:** The app runs in prototype mode without Firebase — login and signup will navigate directly to the home screen.

---

## 🔑 Key Dependencies

```yaml
dependencies:
  flutter_riverpod:       # State management
  go_router:              # Navigation
  shared_preferences:     # Theme persistence
  firebase_auth:          # Authentication
  google_sign_in:         # Google OAuth
  http:                   # Gemini API calls
```

---

## 🤖 AI Features

The AI assistant uses the **Google Gemini API** (`gemini-pro` model) with a travel-specific system prompt. It can:

- Plan multi-day itineraries with cost breakdowns
- Suggest budget transport options
- Recommend local food and budget hotels
- Answer questions about any Indian heritage destination

To enable AI features, add your Gemini API key in `lib/services/gemini_services.dart`.

---

## 🎨 Design System

| Token | Value |
|-------|-------|
| Primary Blue | `#0D1B4B` |
| Primary Cyan | `#00C2CB` |
| Accent Gold | `#F5C518` |
| Font | Outfit (300, 400, 600, 700, 800) |
| Border Radius | 12–32px |

---

## 🗺️ Roadmap

- [ ] Firebase Auth integration (email + Google)
- [ ] More cities: Mumbai, Agra, Chennai, Hyderabad
- [ ] Google Maps integration for place navigation
- [ ] Offline mode with cached data
- [ ] User reviews and ratings
- [ ] Trip sharing feature
- [ ] Push notifications for travel reminders

---

## 🤝 Contributing

Contributions are welcome! Please open an issue first to discuss what you'd like to change.

1. Fork the repository
2. Create your feature branch: `git checkout -b feature/AmazingFeature`
3. Commit your changes: `git commit -m 'Add AmazingFeature'`
4. Push to the branch: `git push origin feature/AmazingFeature`
5. Open a Pull Request

---

## 📄 License

This project is licensed under the MIT License — see the [LICENSE](LICENSE) file for details.

---

## 👤 Author

Built with ❤️ for India's heritage travellers.

> *"Every lane holds centuries of history."*

---

⭐ If you find this project useful, please consider giving it a star on GitHub!
