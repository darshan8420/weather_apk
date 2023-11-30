import 'package:dartz/dartz.dart';
import 'package:weather_api/domain/repository/weather_repository.dart';

import '../../core/error/failure.dart';
import '../entity/weather_entity.dart';

class GetCurrentWeatherUseCase {

  final WeatherRepository weatherRepository;

  GetCurrentWeatherUseCase(this.weatherRepository);

  Future<Either<Failure,WeatherEntity>> execute(String cityName){
    return weatherRepository.getCurrentWeather(cityName);
  }
}