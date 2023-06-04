import 'package:dartz/dartz.dart';

import '../../Core/failures.dart';
import '../entities/weather.dart';
import '../repository/get_weather_repo.dart';

class GetWeatherData {
  final GetWeatherRepo repository;

  GetWeatherData(this.repository);

  Future<Either<Failure, Weather>> execute() async {
    return await repository.getWeatherData(); 
  }
}