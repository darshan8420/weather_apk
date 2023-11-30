import 'package:mockito/annotations.dart';
import 'package:weather_api/data/data_sources/remote_data_source.dart';
import 'package:weather_api/domain/repository/weather_repository.dart';
import 'package:http/http.dart' as http;
import 'package:weather_api/domain/usecases/get_current_weather.dart';

@GenerateMocks(
  [
    WeatherRepository,
    WeatherRemoteDataSource,
    GetCurrentWeatherUseCase,
  ],
  customMocks : [MockSpec<http.Client>(as: #MockHttpClient)],
)

void main() {

}