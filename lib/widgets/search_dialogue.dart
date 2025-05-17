import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/resources/resources.dart';

class SearchDialogue extends StatelessWidget {
  const SearchDialogue({super.key});
  @override
  Widget build(BuildContext context) {
    TextEditingController searchBoxController = TextEditingController();
    final myBorderStyle = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
      borderRadius: BorderRadius.circular(20),
      gapPadding: 4,
    );
    return AlertDialog(
      backgroundColor: Colors.blue.shade900,
      title: Text("Enter City name:", style: primaryTextStyle),
      content: TextField(
        controller: searchBoxController,
        style: secondaryTextStyle,
        cursorColor: Colors.white,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search, color: Colors.white),
          border: myBorderStyle,
          hintText: 'Kathmandu',
          hintStyle: secondaryTextStyle.copyWith(color: Colors.grey),
          focusedBorder: myBorderStyle,
          enabledBorder: myBorderStyle,
          enabled: true,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.close),
          color: Colors.red,
          iconSize: 30,
        ),
        IconButton(
          onPressed: () {
            try {
              final String city = searchBoxController.text;
              if (city.isEmpty) {
                return;
              }
              context.read<WeatherBloc>().add(
                WeatherSearchByCityEvent(city: city),
              );
              Navigator.of(context).pop();
            } catch (e) {
              throw Exception("ERROR: $e");
            }
          },
          icon: Icon(Icons.check),
          color: Colors.greenAccent,
          iconSize: 30,
        ),
      ],
    );
  }
}
