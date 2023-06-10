import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
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
        future: service.getWeatherByLatLon(),
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
              } else if (error is LocationServiceException) {
                return Text("Habilita tu funcion gps");
              } else {
                return Column(
                  children: [
                    Text("Fallo al obtener tu ubicacion"),
                    ElevatedButton(
                      onPressed: () {
                        // Geolocator.openLocationSettings();
                        Geolocator.openAppSettings();
                      },
                      child: Text("Ir a configuraciones de la app"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        service.getWeatherByLatLon();
                      },
                      child: Text("Obtener ubicacion"),
                    ),
                  ],
                );
              }
            }
            final data = snapshot.data;
            if (data != null) {
              return Column(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Tu temperatura actual es ${data.temperatureData.temp} C, con una sensacion de ${data.temperatureData.feelsLike} C',
                          style: TextStyle(
                            fontSize: 32,
                          ),
                        ),
                        Text('${data.weatherDescription.description}'),
                      ],
                    ),
                  ),
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
