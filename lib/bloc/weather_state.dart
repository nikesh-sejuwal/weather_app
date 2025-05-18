// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'weather_bloc.dart';

sealed class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

abstract class WeatherActionState extends WeatherState {}

final class WeatherInitial extends WeatherState {}

class WeatherFetchedSuccessState extends WeatherState {
  final WeatherDataModel datas;

  const WeatherFetchedSuccessState({required this.datas});
}

class WeatherFetchErrorState extends WeatherState {
  final String message;
  const WeatherFetchErrorState({required this.message});
}

class WeatherFetchLoadingState extends WeatherState {}

class WeatherSearchByCityState extends WeatherState {
  final String city;
  const WeatherSearchByCityState({required this.city});
}

class WeatherNavigateToHomeState extends WeatherActionState {}
