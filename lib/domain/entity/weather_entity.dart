import 'package:equatable/equatable.dart';

// ignore: camel_case_types
class WeatherEntity extends Equatable{

  final String main;
  final String description;
  final String cityName;
  final String iconCode;
  final double temperature;
  final int pressure;
  final int humidity;

  const WeatherEntity({

    required this.main,
    required this.description,
    required this.cityName,
    required this.iconCode,
    required this.temperature,
    required this.pressure,
    required this.humidity,

  });

  @override
  List<Object?> get props => [
    cityName,
    main,
    description,
    iconCode,
    temperature,
    pressure,
    humidity
  ];


}