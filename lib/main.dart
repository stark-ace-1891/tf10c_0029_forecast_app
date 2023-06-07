import 'package:flutter/material.dart';
import 'package:tf10c_0029_forecast_app/pages/my_weather_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyWeatherPage(),
    );
  }
}
