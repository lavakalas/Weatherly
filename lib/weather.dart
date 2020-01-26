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

  static Weather fromJson(String json) {
    final Map<String, dynamic> data = jsonDecode(json);

    print(data);

    if (int.parse(data['code']) >= 200 &&
        int.parse(data['code']) < 300) if (data.containsKey('list')) {
      final currentWeather = data['list'][0];

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
    } else {}
    else
      return null;
  }
}
