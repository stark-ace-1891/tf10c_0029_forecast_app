import 'package:flutter/material.dart';
import 'package:tf10c_0029_forecast_app/core/exceptions/exceptions.dart';
import 'package:tf10c_0029_forecast_app/services/weather_service.dart';

class MyWeatherPage extends StatelessWidget {
  final service = WeatherService();
  MyWeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("El clima"),
      ),
      body: FutureBuilder(
        future: service.getWeatherByLatLon(-16.416484, -71.535235),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              final error = snapshot.error;
              if (error is InvalidApiKeyException) {
                return Text("Su api ke es invalida");
              } else if (error is NothingGeocodeException) {
                return Text("Datos proporcionados son invalidos");
              }
            }
            final data = snapshot.data;
            if (data != null) {
              return Column(
                children: [
                  Text('${data.temperatureData.temp}'),
                ],
              );
            }
          }
          return Text("No ha data");
        },
      ),
    );
  }
}
