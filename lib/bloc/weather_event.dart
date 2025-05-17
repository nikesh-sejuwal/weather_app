part of 'weather_bloc.dart';

sealed class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class WeatherInitialEvent extends WeatherEvent {
  final String city;
  const WeatherInitialEvent({this.city = "Pokhara"});

  @override
  List<Object> get props => [city];
}

class WeatherSearchByCityEvent extends WeatherEvent {
  final String city;
  const WeatherSearchByCityEvent({required this.city});

  @override
  List<Object> get props => [city];
}

class WeatherNavigateToHomeEvent extends WeatherEvent {}
