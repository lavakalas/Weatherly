import 'package:weatherly/weather.dart';

class WeatherData {
  String city, country;
  List<Weather> forecast;
  Weather currentWeather;

  WeatherData({this.city, this.country, this.currentWeather, this.forecast});

  void setForecast(List<Weather> _forecast) => forecast = _forecast;
  void setCurrentWeather(Weather weather) => currentWeather = weather;
}
