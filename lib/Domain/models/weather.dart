class Weather {
  final double temperature;
  final double maxTemp;
  final double minTemp;
  final int willItRain;
  final int chanceOfRain;

  const Weather({
    this.temperature = 0,
    this.maxTemp = 0,
    this.minTemp = 0,
    this.chanceOfRain = 0,
    this.willItRain = 0
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      temperature: json['current']['temp_c'],
      maxTemp: json['forecast']['forecastday'][0]['day']['maxtemp_c'],
      minTemp: json['forecast']['forecastday'][0]['day']['mintemp_c'],
      willItRain: json['forecast']['forecastday'][0]['day']['daily_will_it_rain'],
      chanceOfRain: json['forecast']['forecastday'][0]['day']['daily_chance_of_rain'],
    );
  }
}