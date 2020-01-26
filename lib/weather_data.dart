import 'package:weatherly/weather.dart';

class WeatherData {
  num statusCode;
  String city, country;
  List<Weather> forecast;
  Weather currentWeather;

  WeatherData(
      [this.statusCode,
      this.city,
      this.country,
      this.currentWeather,
      this.forecast]);

  void setForecast(List<Weather> _forecast) => forecast = _forecast;
  void setCurrentWeather(List<Weather> _forecast) => forecast = _forecast;
}
