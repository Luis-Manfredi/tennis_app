import '../Data/remote/weather_service.dart';
import '../Data/repository/get_weather_impl.dart';
import '../Domain/entities/weather.dart';
import '../Domain/usercases/get_weather_case.dart';

class WeatherController {
  static Future<Weather> getWeather() async {
    final getWeatherCase = GetWeatherData(GetWeatherImplementation(WeatherService()));
    var getWeather = await getWeatherCase.execute();
    Weather weather = getWeather.foldRight(const Weather(), (r, previous) => r);
    return weather;
  }
}