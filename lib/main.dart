import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_app/ui/WeatherItem.dart';
import 'package:flutter_app/ui/WeatherWidget.dart';

import 'data/ForecastData.dart';
import 'data/WeatherData.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  bool isLoading = false;
  WeatherData weatherData;
  ForecastData forecastData;

  @override
  void initState() {
    super.initState();

    loadWeather();
  }

  loadWeather() async {
    setState(() {
      isLoading = true;
    });

    final lat = 39.555706;
    final lon = 2.621611;
    final appId = "740786603743bcac1abd206371d15c9f";
    final weatherCall = "https://api.openweathermap.org/data/2.5/weather?APPID=$appId&lat=${lat.toString()}&lon=${lon.toString()}&units=metric";
    final forecastCall = "https://api.openweathermap.org/data/2.5/forecast?APPID=$appId&lat=${lat.toString()}&lon=${lon.toString()}&units=metric";

    final weatherResponse = await http.get(weatherCall);
    final forecastResponse = await http.get(forecastCall);

    if (weatherResponse.statusCode == 200 &&
        forecastResponse.statusCode == 200) {
      return setState(() {
        weatherData = new WeatherData.fromJson(jsonDecode(weatherResponse.body));
        forecastData = new ForecastData.fromJson(jsonDecode(forecastResponse.body));
        isLoading = false;
      });
    } else {
      isLoading = false;
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zuhlke Flutter Weather App',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: Scaffold(
          backgroundColor: Colors.purple,
          appBar: AppBar(
            title: Text('Zuhlke Flutter Weather App'),
          ),
          body: Center(
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: weatherData != null
                        ? WeatherWidget(weather: weatherData)
                        : Container(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: isLoading
                        ? CircularProgressIndicator(
                            strokeWidth: 2.0,
                            valueColor:
                                new AlwaysStoppedAnimation(Colors.white),
                          )
                        : IconButton(
                            icon: new Icon(Icons.refresh),
                            tooltip: 'Refresh',
                            onPressed: loadWeather,
                            color: Colors.white,
                          ),
                  ),
                ],
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 200.0,
                  child: forecastData != null ? ListView.builder(
                      itemCount: forecastData.list.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => WeatherItem(weather: forecastData.list.elementAt(index))
                  ) : Container(),
                ),
              ),
            )
          ]))),
    );
  }
}