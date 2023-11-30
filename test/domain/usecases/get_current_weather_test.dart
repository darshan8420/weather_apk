
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_api/domain/entity/weather_entity.dart';
import 'package:weather_api/domain/usecases/get_current_weather.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {

  GetCurrentWeatherUseCase? getCurrentWeatherUseCase;
  MockWeatherRepository? mockWeatherRepository;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    getCurrentWeatherUseCase = GetCurrentWeatherUseCase(mockWeatherRepository!);
  });

  const testWeatherDetail = WeatherEntity(main: 'Clouds', description: 'Few Clouds', cityName: 'New Work', iconCode: '02d', temperature: 302.38, pressure: 1009, humidity: 70);
  const testCityName = 'New York';


  test(
    'should get current weather detail from the repository',
      () async {
      // arrange
        when(
          mockWeatherRepository!.getCurrentWeather(testCityName)
        ).thenAnswer((_) async => const Right(testWeatherDetail));

        // act
        final result = await getCurrentWeatherUseCase!.execute(testCityName);

        //assert
        expect(result, const Right(testWeatherDetail));
      }
  );
}
