

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_api/core/constants/constants.dart';
import 'package:weather_api/core/error/exception.dart';
import 'package:weather_api/data/data_sources/remote_data_source.dart';
import 'package:weather_api/data/models/weather_model.dart';

import '../../helpers/json_reader.dart';
import '../../helpers/test_helper.mocks.dart';
import 'package:http/http.dart' as http;

void main() {

  late MockHttpClient mockHttpClient;
  late WeatherRemoteDataSourceImpl weatherRemoteDataSourceImpl;
  
  setUp(() {
    mockHttpClient = MockHttpClient();
    weatherRemoteDataSourceImpl = WeatherRemoteDataSourceImpl(client: mockHttpClient);
  });
  
  const testCityName = 'New York';
  
  group(
  'get current weather', () {


    test('should return weather Model when the response code is 200', () async {
      //arrange
      when(
        mockHttpClient.get(
          Uri.parse(Urls.currentWeatherByName(testCityName))
        )
      ).thenAnswer(
          (_) async => http.Response(
            readJson('helpers/dummy_data/dummy_weather_response.json'), 200
          )
      );

      //act
      final result = await weatherRemoteDataSourceImpl.getCurrentWeather(testCityName);

      //assert
      expect(result, isA<WeatherModel>());

    });

    test('should return a Server Exception when the response code is 404 or other', () async {
      //arrange
      when(
          mockHttpClient.get(
              Uri.parse(Urls.currentWeatherByName(testCityName))
          )
      ).thenAnswer(
              (_) async => http.Response(
                  'Not found',
                  404
          )
      );

      //act
      // final result = await weatherRemoteDataSourceImpl.getCurrentWeather(testCityName);
      //
      // //assert
      // expect(result, throwsA(isA<ServerException>()));

      expect(() async {
        await weatherRemoteDataSourceImpl.getCurrentWeather(testCityName);
      }, throwsA(isA<ServerException>()));

    });
  });
}