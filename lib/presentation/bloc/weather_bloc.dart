import 'package:weather_api/domain/usecases/get_current_weather.dart';
import 'package:weather_api/presentation/bloc/weather_event.dart';
import 'package:weather_api/presentation/bloc/weather_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentWeatherUseCase _getCurrentWeatherUseCase;
  WeatherBloc (this._getCurrentWeatherUseCase) : super(WeatherEmpty()) {
    on<OnCityChanged> (
      (event, emit) async{
        emit(WeatherLoading());
        final result = await _getCurrentWeatherUseCase.execute(event.cityName);

        // problem in loading the data
        result.fold(
          (failure) {
            emit(WeatherLoadFailure(failure.message));
          },
          (data) {
            emit(WeatherLoaded(data));
          }
        );
      },
        transformer: debounce(const Duration(milliseconds: 500))
    ); 
  }
}

EventTransformer<T> debounce<T> (Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}