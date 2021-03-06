import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weatherly/weather.dart';
import 'package:flutter/cupertino.dart';
import 'package:weather_icons/weather_icons.dart';

import '../constants.dart';

class HomePage extends StatefulWidget {
  final Weather weather;
  PageController _controller = PageController(initialPage: 1, keepPage: false);
  var date = DateTime.now();
  String weekday;
  IconData wicon = WeatherIcons.day_thunderstorm;

  HomePage({Key key, this.weather}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    print('init');

    if (widget.weather.id == 801) {
      if ((widget.date.hour >= 20 && widget.date.hour <= 23) ||
          (widget.date.hour >= 0 && widget.date.hour <= 9)) {
        widget.wicon = FontAwesomeIcons.cloudMoon;
      } else
        widget.wicon = FontAwesomeIcons.cloudSun;
    }
    if (widget.weather.id > 801) {
      widget.wicon = FontAwesomeIcons.cloud;
    }
    if (widget.weather.id >= 700 && widget.weather.id < 800) {
      widget.wicon = FontAwesomeIcons.smog;
    }
    if (widget.weather.id >= 600 && widget.weather.id < 700) {
      widget.wicon = FontAwesomeIcons.snowflake;
    }
    if (widget.weather.id >= 500 && widget.weather.id < 600) {
      widget.wicon = FontAwesomeIcons.cloudRain;
    }
    if (widget.weather.id >= 300 && widget.weather.id < 400) {
      if ((widget.date.hour >= 20 && widget.date.hour <= 23) ||
          (widget.date.hour >= 0 && widget.date.hour <= 9)) {
        widget.wicon = FontAwesomeIcons.cloudMoonRain;
      } else
        widget.wicon = FontAwesomeIcons.cloudSunRain; //Привет Самирка
    }
    if (widget.weather.id >= 200 && widget.weather.id <= 299) {
      if ((widget.date.hour >= 20 && widget.date.hour <= 23) ||
          (widget.date.hour >= 0 && widget.date.hour <= 9)) {
        widget.wicon = WeatherIcons.night_thunderstorm;
      } else
        widget.wicon = WeatherIcons.day_thunderstorm; //Как дела?
    }
    if (widget.weather.id == 800) {
      if ((widget.date.hour >= 20 && widget.date.hour <= 23) ||
          (widget.date.hour >= 0 && widget.date.hour <= 9)) {
        widget.wicon = FontAwesomeIcons.moon;
      } else
        widget.wicon = FontAwesomeIcons.sun;
    }

    if ((widget.weather.temperature - 273.15).toInt() >= 20 && //Д/З сделал уже?
        widget.weather.id == 800) {
      widget.wicon = FontAwesomeIcons.fire; //А то кодит он...
    }
    switch (widget.date.weekday) {
      case 1:
        widget.weekday = 'Monday';
        break;

      case 2:
        widget.weekday = 'Tuesday';
        break;

      case 3:
        widget.weekday = 'Wednesday';
        break;

      case 4:
        widget.weekday = 'Thursday';
        break;

      case 5:
        widget.weekday = 'Friday';
        break;

      case 6:
        widget.weekday = 'Saturday';
        break;

      case 7:
        widget.weekday = 'Sunday';
        break;
    }
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
      controller: widget._controller,
      children: <Widget>[
        Container(
          color: Colors.white,
        ),
        CustomScrollView(slivers: <Widget>[
          SliverAppBar(
              pinned: false,
              snap: true,
              expandedHeight: 300.0,
              title: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 110.0),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(),
                            child: Row(
                              children: <Widget>[
                                Icon(FontAwesomeIcons.city,
                                    color: Colors.white),
                                Text(
                                  '  ${widget.weather.city}, ${widget.weather.country}',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              floating: true,
              stretch: true,
              backgroundColor: Colors.blueAccent,
              flexibleSpace: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Container(
                    width: double.infinity,
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, top: 8.0),
                                  child: Icon(widget.wicon,
                                      size: 70.0, color: Colors.white),
                                )),
                            Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 50.0),
                                child: PopupMenuButton<String>(
                                  icon: Icon(
                                    Icons.more_vert,
                                    color: Colors.white,
                                  ),
                                  onSelected: choiceAction,
                                  itemBuilder: (BuildContext context) {
                                    return Constants.more.map((String choice) {
                                      return PopupMenuItem<String>(
                                        value: choice,
                                        child: Text(choice),
                                      );
                                    }).toList();
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 35.0, right: 90.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 20.0),
                                child: Text(
                                  '${(widget.weather.temperature - 273.15).toInt()}°C',
                                  style: TextStyle(
                                      fontSize: 100.0,
                                      fontFamily: 'Horta',
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 100.0),
                          child: Container(
                              height: 63.0,
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Icon(FontAwesomeIcons.cloud,
                                          size: 20.0, color: Colors.white),
                                      Text(
                                        ' : ${widget.weather.description}',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Icon(FontAwesomeIcons.wind,
                                          size: 20.0, color: Colors.white),
                                      Text(
                                        ': ${widget.weather.windSpeed} m/s',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              )),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.thermometerEmpty,
                      color: Colors.grey,
                    ),
                    Center(
                        child: Text(
                            'RealFeel°: ${(widget.weather.feels - 273.15).toInt()}°C',
                            style: TextStyle(fontSize: 20.0))),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.snowflake,
                      color: Colors.cyanAccent,
                    ),
                    Center(
                        child: Text(
                            'Min temperature: ${(widget.weather.minTemp - 273.15).toInt()}°C',
                            style: TextStyle(fontSize: 20.0))),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.fire,
                      color: Colors.deepOrange,
                    ),
                    Center(
                        child: Text(
                            'Max temperature: ${(widget.weather.maxTemp - 273.15).toInt()}°C',
                            style: TextStyle(fontSize: 20.0))),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.tint,
                      color: Colors.indigo,
                    ),
                    Center(
                        child: Text('Humidity: ${widget.weather.humidity}%',
                            style: TextStyle(fontSize: 20.0))),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Icon(
                        WeatherIcons.barometer,
                        color: Colors.indigo,
                      ),
                    ),
                    Center(
                        child: Text(
                      'Pressure: ${(widget.weather.pressure * 0.0075).toString()[0]}${(widget.weather.pressure * 0.0075).toString()[2]}${(widget.weather.pressure * 0.0075).toString()[3]}mmHg',
                      style: TextStyle(fontSize: 20.0),
                    )),
                  ],
                ),
              )
            ]),
          )
        ]),
        Container(
          color: Colors.blueAccent,
        ),
      ],
    ));
  }

  void choiceAction(String choice) {
    switch (choice) {
      case 'Information':
        showDialog(
            context: context,
            // ignore: missing_return
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Weathery v1.0.0'),
                content: Container(
                  height: 300.0,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 41.0),
                        child: Image.asset(
                          'assets/info.png',
                          width: 150,
                          height: 150,
                        ),
                      ),
                      Text('Developed by: Lavakalas(Ilya)\n K4RT0F3L (Samir) \n'
                          'Contact information: lavakalas@mail.ru, \n debilpolski15@gmail.com')
                    ],
                  ),
                ),
              );
            });
        break;

      case 'Exit':
        SystemNavigator.pop();
        break;
    }
  }
}
