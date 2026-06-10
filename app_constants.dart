class AppConstants {
  // ─── Route Names ─────────────────────────────────────────────────────────
  static const String splashRoute = '/';
  static const String loginRoute = '/login';
  static const String signupRoute = '/signup';
  static const String homeRoute = '/home';
  static const String cityRoute = '/city';
  static const String placeDetailRoute = '/place';
  static const String chatRoute = '/chat';
  static const String plannerRoute = '/planner';
  static const String mapRoute = '/map';
  static const String profileRoute = '/profile';

  // ─── Hive Box Names ───────────────────────────────────────────────────────
  static const String favoritesBox = 'favorites';
  static const String cachedPlacesBox = 'cached_places';
  static const String userPrefsBox = 'user_prefs';

  // ─── SharedPreferences Keys ───────────────────────────────────────────────
  static const String themeKey = 'app_theme';
  static const String onboardedKey = 'onboarded';
  static const String selectedCityKey = 'selected_city';

  // ─── App Info ─────────────────────────────────────────────────────────────
  static const String appName = 'HeritageHop';
  static const String appTagline = 'Explore India\'s Soul';

  // ─── API ──────────────────────────────────────────────────────────────────
  static const String geminiBaseUrl =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent';
}