import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiService {
  static const String _apiKey = 'YOUR_GEMINI_API_KEY_HERE';
  static const String _baseUrl =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent';

  static const String _systemContext = '''
You are HeritageHop AI, an expert Indian travel assistant.
Help tourists with heritage places, budget travel, cheap transport,
hotels, and local food across India. Always use Indian Rupees for costs.
''';

  static Future<String> sendMessage(String userMessage) async {
    if (_apiKey == 'YOUR_GEMINI_API_KEY_HERE') {
      return '⚠️ Please add your Gemini API key in gemini_service.dart to enable AI features.\n\nFor now, try these sample tips:\n\n🏛️ Victoria Memorial — Best visited in the morning\n🚇 Use Kolkata Metro for cheap transport (₹5–25)\n🍛 Try Kathi rolls at Park Street for authentic street food\n🏨 Budget hotels near Howrah start from ₹500/night';
    }

    try {
      final response = await http.post(
        Uri.parse('$_baseUrl?key=$_apiKey'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'contents': [
            {
              'parts': [
                {'text': '$_systemContext\n\nUser: $userMessage'}
              ]
            }
          ],
          'generationConfig': {
            'temperature': 0.7,
            'maxOutputTokens': 1024,
          },
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final text =
        data['candidates']?[0]?['content']?['parts']?[0]?['text'];
        return text ?? 'Sorry, I could not generate a response.';
      } else if (response.statusCode == 400) {
        return '⚠️ Invalid API key. Please check your Gemini API key.';
      } else {
        return 'Error ${response.statusCode}. Please try again.';
      }
    } catch (e) {
      return 'Network error. Please check your connection.';
    }
  }

  static Future<String> generateItinerary({
    required String city,
    required int days,
    required double budget,
    required List<String> interests,
  }) async {
    final prompt =
        'Generate a detailed $days-day itinerary for $city, India with ₹${budget.toStringAsFixed(0)} budget. Interests: ${interests.join(', ')}. Include morning/afternoon/evening activities, costs, transport and food suggestions.';
    return sendMessage(prompt);
  }
}