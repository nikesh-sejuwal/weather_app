import 'dart:convert';

class WeatherDataModel {
  final double temp, feelTemp, maxTemp, minTemp, humidity, windspeed;
  final String weather, weatherdescription, country, city;
  final DateTime sunrise, sunset;
  WeatherDataModel({
    required this.city,
    required this.country,
    required this.temp,
    required this.feelTemp,
    required this.maxTemp,
    required this.minTemp,
    required this.humidity,
    required this.windspeed,
    required this.weatherdescription,
    required this.weather,
    required this.sunrise,
    required this.sunset,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'temp': temp,
      'city': city,
      'weather': weather,
      'feelTemp': feelTemp,
      'country': country,
      'maxTemp': maxTemp,
      'minTemp': minTemp,
      'humidity': humidity,
      'windspeed': windspeed,
      'weatherdescription': weatherdescription,
      'sunrise': sunrise.toIso8601String(),
      'sunset': sunset.toIso8601String(),
    };
  }

  factory WeatherDataModel.fromMap(Map<String, dynamic> map) {
    return WeatherDataModel(
      city: map['name'] as String,
      weather: map['weather'][0]['main'] as String,
      country: map['sys']['country'] as String,
      temp: (map['main']['temp'] as num).toDouble(),
      feelTemp: (map['main']['feels_like'] as num).toDouble(),
      maxTemp: (map['main']['temp_max'] as num).toDouble(),
      minTemp: (map['main']['temp_min'] as num).toDouble(),
      humidity: (map['main']['humidity'] as num).toDouble(),
      windspeed: (map['wind']['speed'] as num).toDouble(),
      weatherdescription: map['weather'][0]['description'] as String,
      sunrise: DateTime.fromMillisecondsSinceEpoch(
        (map['sys']['sunrise'] as int) * 1000,
      ),
      sunset: DateTime.fromMillisecondsSinceEpoch(
        (map['sys']['sunset'] as int) * 1000,
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherDataModel.fromJson(String source) =>
      WeatherDataModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
