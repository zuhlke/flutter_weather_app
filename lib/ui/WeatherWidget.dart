import 'package:flutter/material.dart';
import 'package:flutter_app/data/WeatherData.dart';

import 'package:intl/intl.dart';

class WeatherWidget extends StatelessWidget {
  final WeatherData weather;

  WeatherWidget({Key key, @required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(weather.name, style: new TextStyle(color: Colors.white, fontSize: 25.0)),
        Image.network('https://openweathermap.org/img/w/${weather.icon}.png',
            scale: 0.4),
        Text(weather.main, style: new TextStyle(color: Colors.white, fontSize: 20.0)),
        Text('${weather.temp.toString()}°C', style: new TextStyle(color: Colors.white)),
        Text(new DateFormat.yMMMd().format(weather.date), style: new TextStyle(color: Colors.white)),
        Text(new DateFormat.Hm().format(weather.date), style: new TextStyle(color: Colors.white)),
      ],
    );
  }
}
