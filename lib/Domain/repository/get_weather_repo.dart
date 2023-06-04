import 'package:dartz/dartz.dart';

import '../../Core/failures.dart';
import '../entities/weather.dart';

abstract class GetWeatherRepo {
  Future<Either<Failure, Weather>> getWeatherData();
}