import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  final String? apiKey = dotenv.env["API_KEY"];

  Future<Map<String, dynamic>> getWeather(String cityName) async {
    final url =
        "http://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw Exception("Failed to Load Data");
  }

  Future<Map<String, dynamic>> fetchWeather(String cityName) async {
    Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    ));

    double lat = position.latitude, lon = position.longitude;

    final url =
        "http://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw Exception("Failed to Load Data");
  }
}
