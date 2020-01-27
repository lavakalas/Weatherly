import 'dart:convert';

class Weather {
  String city, main, description, country;
  num temperature, maxTemp, minTemp, feels, windSpeed, humidity, pressure;
  int id;

  Weather(
      {this.city,
      this.description,
      this.main,
      this.temperature,
      this.windSpeed,
      this.country,
      this.id,
      this.maxTemp,
      this.minTemp,
      this.humidity,
      this.pressure,
      this.feels});

  static List<Weather> fromJsonForecast(String json) {
    final Map<String, dynamic> data = jsonDecode(json);

//    print(data);

    if (int.parse(data['cod']) >= 200 && int.parse(data['cod']) < 300) {
      final List<Weather> currentForecast = [];

      for (int i = 0; i < data['list'].length; i++) {
        final currentWeather = data['list'][i];

        currentForecast.add(Weather(
          humidity: currentWeather['main']['humidity'],
          windSpeed: currentWeather['wind']['speed'],
          pressure: currentWeather['main']['pressure'],
          temperature: currentWeather['main']['temp'],
          description: currentWeather['weather'][0]['description'],
          main: currentWeather['weather'][0]['description'],
          feels: currentWeather['main']['feels_like'],
          id: currentWeather['weather'][0]['id'],
          maxTemp: currentWeather['main']['temp_max'],
          minTemp: currentWeather['main']['temp_min'],
          country: data['country'],
          city: data['city']['name'],
        ));
      }
      return currentForecast;
    } else
      return null;
  }

  static Weather fromJson(String json) {
    Map<String, dynamic> data = jsonDecode(json);

    if (data['cod'] >= 200 && data['cod'] < 300) {
      return Weather(
        country: data['name'],
        city: data['sys']['country'],
        main: data['weather'][0]['main'],
        description: data['weather'][0]['description'],
        temperature: data['main']['temp'],
        feels: data['main']['feels_like'],
        minTemp: data['main']['temp_min'],
        maxTemp: data['main']['temp_max'],
        id: data['weather'][0]['id'],
        pressure: data['main']['pressure'],
        humidity: data['main']['humidity'],
        windSpeed: data['wind']['speed'],
      );
    } else
      return null;
  }
}
