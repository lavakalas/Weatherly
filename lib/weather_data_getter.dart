import 'dart:convert';

import 'package:weatherly/weather.dart';
import 'package:http/http.dart' as http;
import 'package:weatherly/weather_data.dart';

// 1539a383d823965800c50ec8b158a02f

class WeatherRepository {
  WeatherData loadedWeatherForecast;

  Future<void> getWeatherViaLonAndLat(num lat, num lon) async {
    await http.get(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&units=metric',
        headers: {'x-api-key': '1539a383d823965800c50ec8b158a02f'}).then((v) {
      if (v.statusCode >= 200 && v.statusCode < 300) {
        loadedWeatherForecast = Weather.fromJson(v.body);
      } else {
        print('error');
        return null;
      }
    }).catchError((error) {
      print(error);
      print(14);
      return null;
    });
  }

  Future<void> getWeatherViaCountryName(String name) async {
    await http
        .get(
            'http://api.openweathermap.org/data/2.5/forecast?q=$name&units=metric&appid=1539a383d823965800c50ec8b158a02f')
        .then((v) {
      if (v.statusCode >= 200 && v.statusCode < 300) {
        final data = jsonDecode(v.body);
        num code = int.parse(data['cod']);
        if (code == 200) {
          loadedWeatherForecast = Weather.fromJson(v.body);
        } else {
          loadedWeatherForecast = null;
          return null;
        }
      } else {
        loadedWeatherForecast = null;
      }
    }).catchError((error) {
      print(error);
      print(14);
      return error;
    });
  }
}
