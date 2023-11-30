

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:weather_api/data/models/weather_model.dart';
import 'package:weather_api/domain/entity/weather_entity.dart';

import '../../helpers/json_reader.dart';

void main() {

  const testWeatherModel = WeatherModel(
      cityName: 'New York',
      main: 'Clouds',
      description: 'Few Clouds',
      iconCode: '02d',
      temperature: 302.38,
      pressure: 1009,
      humidity: 70,
  );

  test(
    'should be a subclass of weather entity',
      () async {
      //assert
        expect(testWeatherModel, isA<WeatherEntity>());
      }
  );

  test(
    'should return a valid model from a json',
      () async {
      //arrange
        final Map<String, dynamic> jsonMap = json.decode(
          readJson('helpers/dummy_data/dummy_weather_response.json'),
        );

        //act
        final result = WeatherModel.fromJson(jsonMap);

        //assert
        expect(result, equals(testWeatherModel));
      }
  );

  test(
    'should retrun a json map containing proper data',
      () async {

      //act
        final result = testWeatherModel.toJson();

        //assert
        final expectedJsonMap = {
          'weather': [{
            'main': 'Clouds',
            'description': 'Few Clouds',
            'icon': '02d',
          }],
          'main': {
            'temp': 302.38,
            'pressure': 1009,
            'humidity': 70
          },
          'name': 'New York',
        };

        //arrange
        expect(result, equals(expectedJsonMap));
      }

  );
}