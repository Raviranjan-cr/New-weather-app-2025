import 'dart:convert';
import 'package:http/http.dart' as http;
import 'weather_model.dart';

class WeatherService {
  final String apiKey = 'YOUR_API_KEY'; // Replace with your actual API key
  final String apiUrl = 'https://api.openweathermap.org/data/2.5/weather';

  Future<Weather> fetchWeather(String city) async {
    final response = await http.get(
      Uri.parse('$apiUrl?q=$city&appid=$apiKey&units=metric'),
    );

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather');
    }
  }
}
