import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weatherly/weather.dart';

class WeatherRepository {
  Weather loadedWeatherForCurrentTown, loadedDataForChoosenTown;

  List<Weather> loadedWeatherForChoosenTownForecast;

  Future<void> getWeatherForCurrentTown(num lat, num lon) async {
    await http.get(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon',
        headers: {'x-api-key': '1539a383d823965800c50ec8b158a02f'}).then((v) {
      if (v.statusCode >= 200 && v.statusCode < 300) {
        loadedWeatherForCurrentTown = Weather.fromJson(v.body);
      } else {
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
            'http://api.openweathermap.org/data/2.5/weather?q=$name&appid=1539a383d823965800c50ec8b158a02f')
        .then((v) {
      if (v.statusCode >= 200 && v.statusCode < 300) {
        final data = jsonDecode(v.body);
        num code = int.parse(data['cod']);
        if (code == 200) {
          loadedDataForChoosenTown = Weather.fromJson(v.body);
        } else {
          loadedDataForChoosenTown = null;
          return null;
        }
      } else {
        loadedDataForChoosenTown = null;
      }
    }).catchError((error) {
      print(error);
      print(14);
      return error;
    });
  }

  Future<void> getWeatherForChoosenTownForecast(String name) async {
    await http
        .get(
            'http://api.openweathermap.org/data/2.5/forecast?q=$name&appid=1539a383d823965800c50ec8b158a02f')
        .then((v) {
      if (v.statusCode >= 200 && v.statusCode < 300) {
        final data = jsonDecode(v.body);
        num code = int.parse(data['cod']);
        if (code == 200) {
          loadedWeatherForChoosenTownForecast =
              Weather.fromJsonForecast(v.body);
        } else {
          loadedWeatherForChoosenTownForecast = null;
          return null;
        }
      } else {
        loadedWeatherForChoosenTownForecast = null;
      }
    }).catchError((error) {
      print(error);
      print(14);
      return error;
    });
  }
}
