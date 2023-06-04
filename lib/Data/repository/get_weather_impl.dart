import 'package:tennis_app/Core/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tennis_app/Data/remote/weather_service.dart';
import 'package:tennis_app/Domain/entities/weather.dart';
import 'package:tennis_app/Domain/repository/get_weather_repo.dart';

class GetWeatherImplementation implements GetWeatherRepo {
  final WeatherService weatherService;
  GetWeatherImplementation(this.weatherService);

  @override
  Future<Either<Failure, Weather>> getWeatherData() async {
    try {
      final weather = await weatherService.getWeatherData();
      return Right(weather);
    } on ServerFailure {
      return Left(ServerFailure());
    }
  }
}