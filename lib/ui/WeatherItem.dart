import 'package:flutter/material.dart';
import 'package:flutter_app/data/WeatherData.dart';
import 'package:intl/intl.dart';

class WeatherItem extends StatelessWidget {

  final WeatherData weather;

  WeatherItem({Key key, @required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network('https://openweathermap.org/img/w/${weather.icon}.png', scale: 0.6),
            Text(weather.main, style: new TextStyle(color: Colors.black, fontSize: 20.0)),
            Text('${weather.temp.toString()}°C',  style: new TextStyle(color: Colors.black)),
            Text(new DateFormat.yMMMd().format(weather.date), style: new TextStyle(color: Colors.black)),
            Text(new DateFormat.Hm().format(weather.date), style: new TextStyle(color: Colors.black)),
          ],
        ),
      ),
    );
  }
}