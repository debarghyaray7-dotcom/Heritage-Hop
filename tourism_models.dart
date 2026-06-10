// ─── Place Model ─────────────────────────────────────────────────────────────
class TourismPlace {
  final String id;
  final String name;
  final String cityId;
  final String category; // heritage | attraction | food | hotel
  final String description;
  final String fullDescription;
  final String imageUrl;
  final List<String> galleryImages;
  final double rating;
  final int reviewCount;
  final String entryFee;
  final String timing;
  final String bestTimeToVisit;
  final double latitude;
  final double longitude;
  final String address;
  final List<String> nearbyTransport;
  final List<String> travelTips;
  final String estimatedBudget;
  final List<String> nearbyFood;
  final List<String> nearbyHotels;
  bool isFavorite;

  TourismPlace({
    required this.id,
    required this.name,
    required this.cityId,
    required this.category,
    required this.description,
    required this.fullDescription,
    required this.imageUrl,
    required this.galleryImages,
    required this.rating,
    required this.reviewCount,
    required this.entryFee,
    required this.timing,
    required this.bestTimeToVisit,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.nearbyTransport,
    required this.travelTips,
    required this.estimatedBudget,
    required this.nearbyFood,
    required this.nearbyHotels,
    this.isFavorite = false,
  });

  TourismPlace copyWith({bool? isFavorite}) => TourismPlace(
    id: id,
    name: name,
    cityId: cityId,
    category: category,
    description: description,
    fullDescription: fullDescription,
    imageUrl: imageUrl,
    galleryImages: galleryImages,
    rating: rating,
    reviewCount: reviewCount,
    entryFee: entryFee,
    timing: timing,
    bestTimeToVisit: bestTimeToVisit,
    latitude: latitude,
    longitude: longitude,
    address: address,
    nearbyTransport: nearbyTransport,
    travelTips: travelTips,
    estimatedBudget: estimatedBudget,
    nearbyFood: nearbyFood,
    nearbyHotels: nearbyHotels,
    isFavorite: isFavorite ?? this.isFavorite,
  );
}

// ─── City Model ───────────────────────────────────────────────────────────────
class City {
  final String id;
  final String name;
  final String state;
  final String description;
  final String imageUrl;
  final double latitude;
  final double longitude;
  final String bestSeason;
  final String language;

  const City({
    required this.id,
    required this.name,
    required this.state,
    required this.description,
    required this.imageUrl,
    required this.latitude,
    required this.longitude,
    required this.bestSeason,
    required this.language,
  });
}

// ─── Chat Message Model ───────────────────────────────────────────────────────
class ChatMessage {
  final String id;
  final String content;
  final bool isUser;
  final DateTime timestamp;
  final bool isLoading;

  const ChatMessage({
    required this.id,
    required this.content,
    required this.isUser,
    required this.timestamp,
    this.isLoading = false,
  });

  ChatMessage copyWith({String? content, bool? isLoading}) => ChatMessage(
    id: id,
    content: content ?? this.content,
    isUser: isUser,
    timestamp: timestamp,
    isLoading: isLoading ?? this.isLoading,
  );
}

// ─── Day Plan Model ───────────────────────────────────────────────────────────
class DayPlan {
  final int day;
  final String title;
  final String morningActivity;
  final String afternoonActivity;
  final String eveningActivity;
  final double estimatedCost;

  const DayPlan({
    required this.day,
    required this.title,
    required this.morningActivity,
    required this.afternoonActivity,
    required this.eveningActivity,
    required this.estimatedCost,
  });
}

// ─── Travel Plan Model ────────────────────────────────────────────────────────
class TravelPlan {
  final String cityName;
  final int days;
  final double budget;
  final List<DayPlan> dayPlans;
  final double estimatedTotal;
  final String transportSummary;
  final List<String> hotelSuggestions;
  final List<String> foodRecommendations;

  const TravelPlan({
    required this.cityName,
    required this.days,
    required this.budget,
    required this.dayPlans,
    required this.estimatedTotal,
    required this.transportSummary,
    required this.hotelSuggestions,
    required this.foodRecommendations,
  });
}