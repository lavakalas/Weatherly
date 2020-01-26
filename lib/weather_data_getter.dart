import 'dart:convert';

import 'package:weatherly/weather.dart';
import 'package:http/http.dart' as http;

// 1539a383d823965800c50ec8b158a02f

class WeatherRepository {
  Weather loadedWeatherForCurrentTown;

  Future<void> getWeatherForCurrentTown(String city) async {
    await http.get(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric',
        headers: {'x-api-key': '1539a383d823965800c50ec8b158a02f'}).then((v) {
      if (v.statusCode >= 200 && v.statusCode < 300) {
        loadedWeatherForCurrentTown = Weather.fromJson(v.body);
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

  Future<void> getWeatherForChoosenTown(String name) async {
    await http
        .get(
            'http://api.openweathermap.org/data/2.5/forecast?q=$name&units=metric&appid=1539a383d823965800c50ec8b158a02f')
        .then((v) {
      if (v.statusCode >= 200 && v.statusCode < 300) {
        final data = jsonDecode(v.body);
        num code = int.parse(data['cod']);
        if (code == 200) {
          loadedWeatherForCurrentTown = Weather.fromJson(v.body);
        } else {
          loadedWeatherForCurrentTown = null;
          return null;
        }
      } else {
        loadedWeatherForCurrentTown = null;
      }
    }).catchError((error) {
      print(error);
      print(14);
      return error;
    });
  }
}
