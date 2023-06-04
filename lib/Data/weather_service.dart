import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Domain/models/weather.dart';
import '../Utils/api_utils.dart';

class WeatherService {
  Future<Weather> getWeatherData(String place) async {
    try {
      final queryParameters = {
        'key': APIUtils.key,
        'q': place
      };

      final uri = Uri.http('api.weatherapi.com', '/v1/forecast.json', queryParameters);

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        // print('API connected successfully');
        return Weather.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Could not get weather data');
      }
    } catch (e) {
      throw Exception(e);
    }

  }
}