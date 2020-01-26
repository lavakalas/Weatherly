import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherly/pages/geo_page.dart';

import 'package:weatherly/pages/home_page.dart';
import 'package:weatherly/pages/loading_page.dart';
import 'package:weatherly/weather_data_getter.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoading = true;
  WeatherRepository weatherRepository = WeatherRepository();

  void loading() async {
    Position position = await Geolocator().getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    num lon = position.longitude;
    num lat = position.latitude;
    await weatherRepository.getWeatherForCurrentTown('wow').then((value) {
      print(weatherRepository.loadedWeatherForCurrentTown);
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    loading();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: "Weathery",
      color: Colors.blueAccent,
      home: isLoading
          ? LoadingPage()
          : HomePage(
              weather: weatherRepository.loadedWeatherForCurrentTown,
            ),
      routes: {
        '/home': ((BuildContext context) => HomePage()),
        '/loading': ((BuildContext context) => LoadingPage()),
        '/error': ((BuildContext context) => GeoPage())
      },
    );
  }
}
