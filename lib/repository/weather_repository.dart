import 'dart:convert';

import 'package:weather_app/model/weather_data_model.dart';
import 'package:http/http.dart' as http;

class WeatherRepository {
  static Future<WeatherDataModel> fetchWeatherData(String city) async {
    try {
      var response = await http.get(
        Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=eb1ecbbf5b3f92f014962bb412ae336a&units=metric',
        ),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to fetch weather data: ${response.statusCode}');
      }
      var decodedInfo = jsonDecode(response.body);
      WeatherDataModel datas = WeatherDataModel.fromMap(decodedInfo);
      return datas;
    } catch (e) {
      throw Exception("ERROR OCCURS: $e");
    }
  }
}
