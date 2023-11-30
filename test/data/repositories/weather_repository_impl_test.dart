

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_api/core/error/exception.dart';
import 'package:weather_api/core/error/failure.dart';
import 'package:weather_api/data/models/weather_model.dart';
import 'package:weather_api/data/repositories/weather_repository_impl.dart';
import 'package:weather_api/domain/entity/weather_entity.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {

  late MockWeatherRemoteDataSource mockWeatherRemoteDataSource;
  late WeatherRepositoryImpl weatherRepositoryImpl;

  setUp((){
    mockWeatherRemoteDataSource = MockWeatherRemoteDataSource();
    weatherRepositoryImpl = WeatherRepositoryImpl(weatherRemoteDataSource: mockWeatherRemoteDataSource);
  });

  const testWeatherModel = WeatherModel(
    cityName: 'New York',
    main: 'Clouds',
    description: 'Few Clouds',
    iconCode: '02d',
    temperature: 302.38,
    pressure: 1009,
    humidity: 70,
  );

  const testWeatherEntity = WeatherEntity(
    cityName: 'New York',
    main: 'Clouds',
    description: 'Few Clouds',
    iconCode: '02d',
    temperature: 302.38,
    pressure: 1009,
    humidity: 70,
  );

  const testCityName = 'New York';

  group('get current weather', () {

    test('should return current weather when a call to data source is successful', () async {
      //arrange
      when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName)).thenAnswer((_) async=> testWeatherModel);

      //act
      final result = await weatherRepositoryImpl.getCurrentWeather(testCityName);

      //assert
      expect(result, equals(const Right(testWeatherEntity)));
    });

    test('should return server failure when a call to data source is unsuccessful', () async {
      //arrange
      when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName)).thenThrow(ServerException());

      //act
      final result = await weatherRepositoryImpl.getCurrentWeather(testCityName);

      //assert
      expect(result, equals(const Left(ServerFailure('An error has occurred'))));
    });

    test('should return connection failure when device has no internet', () async {
      //arrange
      when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName)).thenThrow(const SocketException('An error has occured'));

      //act
      final result = await weatherRepositoryImpl.getCurrentWeather(testCityName);

      //assert
      expect(result, equals(const Left(ConnectionFailure('failed to connect to the network'))));
    });
  });

}