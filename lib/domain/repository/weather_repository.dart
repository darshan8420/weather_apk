import 'package:dartz/dartz.dart';
import 'package:weather_api/domain/entity/weather_entity.dart';
import '../../core/error/failure.dart';

abstract class WeatherRepository{

  Future<Either<Failure,WeatherEntity>> getCurrentWeather(String cityName);
}