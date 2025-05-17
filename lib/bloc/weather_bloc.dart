import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/model/weather_data_model.dart';
import 'package:weather_app/repository/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<WeatherInitialEvent>(weatherInitialEvent);
    on<WeatherSearchByCityEvent>(weatherSearchByCityEvent);
    on<WeatherNavigateToHomeEvent>(weatherNavigateToHomeEvent);
  }

  FutureOr<void> weatherInitialEvent(
    WeatherInitialEvent event,
    Emitter<WeatherState> emit,
  ) async {
    try {
      emit(WeatherFetchLoadingState());

      WeatherDataModel datas = await WeatherRepository.fetchWeatherData(
        event.city,
      );
      emit(WeatherFetchedSuccessState(datas: datas));
    } catch (e) {
      emit(WeatherFetchErrorState());
    }
  }

  FutureOr<void> weatherSearchByCityEvent(
    WeatherSearchByCityEvent event,
    Emitter<WeatherState> emit,
  ) async {
    try {
      emit(WeatherFetchLoadingState());
      WeatherDataModel weatherData = await WeatherRepository.fetchWeatherData(
        event.city,
      );
      emit(WeatherFetchedSuccessState(datas: weatherData));
    } catch (e) {
      emit(WeatherFetchErrorState());
    }
  }

  FutureOr<void> weatherNavigateToHomeEvent(
    WeatherNavigateToHomeEvent event,
    Emitter<WeatherState> emit,
  ) {
    emit(WeatherNavigateToHomeState());
  }
}
