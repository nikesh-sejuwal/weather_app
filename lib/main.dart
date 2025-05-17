import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/weather_bloc.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => WeatherBloc(),
      child: MaterialApp(debugShowCheckedModeBanner: false, home: HomeScreen()),
    ),
  );
}
