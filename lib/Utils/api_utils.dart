import 'package:flutter_dotenv/flutter_dotenv.dart';

class APIUtils {
  static String key = dotenv.env['WEATHER_API_KEY'].toString();
}