

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:weather_api/core/error/exception.dart';
import 'package:weather_api/core/error/failure.dart';
import 'package:weather_api/data/data_sources/remote_data_source.dart';
import 'package:weather_api/domain/entity/weather_entity.dart';
import 'package:weather_api/domain/repository/weather_repository.dart';

class WeatherRepositoryImpl extends WeatherRepository {

  final WeatherRemoteDataSource weatherRemoteDataSource;
  WeatherRepositoryImpl({required this.weatherRemoteDataSource});

  @override
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(String cityName) async {
    try {
      final result = await weatherRemoteDataSource.getCurrentWeather(cityName);
      return Right(result.toEntity());
    } on ServerException{
      return const Left(ServerFailure('An error has occured'));
    } on SocketException{
      return const Left(ConnectionFailure('failed to connect to the network'));
    }
  }
}