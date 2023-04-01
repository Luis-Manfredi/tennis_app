import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Domain/models/weather.dart';

class WeatherService {
  Future<Weather> getWeatherData(String place) async {
    // API Key: 985852e195054f4db4f155612220912

    try {
      final queryParameters = {
        'key': '985852e195054f4db4f155612220912',
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