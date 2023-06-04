import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../Domain/entities/weather.dart';
import '../../Utils/api_utils.dart';

abstract class WeatherAPIData {
  Future<Weather> getWeatherData();
}

class WeatherService extends WeatherAPIData {
  @override
  Future<Weather> getWeatherData() async {
    try {
      final queryParameters = {
        'key': APIUtils.key,
        'q': 'Caracas'
      };

      final uri = Uri.http('api.weatherapi.com', '/v1/forecast.json', queryParameters);

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        print(response.body);
        return Weather.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Could not get weather data');
      }
    } catch (e) {
      throw Exception(e);
    }

  }
}