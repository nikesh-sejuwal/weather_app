import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/resources/resources.dart';
import 'package:weather_app/widgets/custom_background.dart';
import 'package:weather_app/widgets/custom_details_with_icon.dart';
import 'package:weather_app/widgets/search_dialogue.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<WeatherBloc>().add(WeatherInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    Widget getWeatherImage(String weather) {
      switch (weather) {
        case "Clouds":
          return Image.asset('assets/images/clouds.png');
        case "Rain":
          return Image.asset('assets/images/rain.png');
        case "Dizzle":
          return Image.asset('assets/images/dizzle.png');
        case "Snow":
          return Image.asset('assets/images/snow.png');
        case "Mist":
          return Image.asset('assets/images/mist.png');
        case "Clear":
          return Image.asset('assets/images/clear.png');
        case "Thunderstrom":
          return Image.asset('assets/images/thunderstrom.png');
        default:
          return Image.asset('assets/images/cloudcovernance.png');
      }
    }

    var formatter = DateFormat.jm();
    return BlocConsumer<WeatherBloc, WeatherState>(
      listenWhen: (previous, current) => current is WeatherActionState,
      buildWhen: (previous, current) => current is! WeatherActionState,
      listener: (context, state) {
        if (state is WeatherNavigateToHomeState) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case const (WeatherFetchErrorState):
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.white,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "ERROR WHILE FETCHING DATA",
                      style: TextStyle(fontSize: 25),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.read<WeatherBloc>().add(
                          WeatherNavigateToHomeEvent(),
                        );
                      },
                      child: Text("Navigate to home page"),
                    ),
                  ],
                ),
              ),
            );
          case const (WeatherFetchLoadingState):
            return Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          case const (WeatherFetchedSuccessState):
            final data = state as WeatherFetchedSuccessState;
            return CustomBackground(
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => SearchDialogue(),
                        );
                      },
                      icon: Icon(Icons.search, size: 30, color: Colors.white),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${data.datas.city}, ${data.datas.country}",
                        style: headingTextStyle.copyWith(fontSize: 30),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 10),
                      Text(
                        data.datas.weatherdescription,
                        style: primaryTextStyle,
                      ),
                      getWeatherImage(data.datas.weather),
                      Text(
                        "${(data.datas.temp).toInt()}°c",
                        style: headingTextStyle,
                      ),
                      Text(
                        "feels like ${data.datas.feelTemp}°c",
                        style: secondaryTextStyle,
                      ),
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(top: 20),
                          width: MediaQuery.of(context).size.width * 0.85,
                          decoration: BoxDecoration(color: Colors.transparent),
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomDetailsWithIcon(
                                    detail: formatter.format(
                                      data.datas.sunrise,
                                    ),
                                    img: "assets/images/sunrise.png",
                                    title: "Sunrise",
                                  ),
                                  CustomDetailsWithIcon(
                                    detail: formatter.format(data.datas.sunset),
                                    img: "assets/images/sunset.png",
                                    title: "Sunset",
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CustomDetailsWithIcon(
                                    detail: "${(data.datas.minTemp).toInt()}°c",
                                    img: "assets/images/min.png",
                                    title: "min temp",
                                  ),
                                  CustomDetailsWithIcon(
                                    detail: "${(data.datas.maxTemp).toInt()}°c",
                                    img: "assets/images/max.png",
                                    title: "max temp",
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CustomDetailsWithIcon(
                                    detail: "${data.datas.humidity}%",
                                    img: "assets/images/humidity.png",
                                    title: "Humidity",
                                  ),
                                  CustomDetailsWithIcon(
                                    detail: "${data.datas.windspeed}m/s",
                                    img: "assets/images/wind.png",
                                    title: "Wind Speed",
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          default:
            return Container(color: Colors.white);
        }
      },
    );
  }
}
