import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:weather_report/components/response_weather.dart';
import 'package:weather_report/models/time_weather.dart';
import 'package:weather_report/util/app_logger.dart';
import 'package:http/http.dart' as http;

class Api {
  final Dio dio = Dio(BaseOptions(
    connectTimeout: const Duration(milliseconds: 15000),
    sendTimeout: const Duration(milliseconds: 15000),
    receiveTimeout: const Duration(milliseconds: 15000),
  ))
    ..interceptors.add(PrettyDioLogger())
    ..interceptors.add(
      InterceptorsWrapper(
        onError: (e, handler) {
          logError("Request error: ${e.message}");
          return handler.next(e);
        },
        onRequest: (r, handler) {
          logInfo("Requesting: $r");
          return handler.next(r);
        },
        onResponse: (r, handler) {
          logInfo("Request sent: $r");
          return handler.next(r);
        },
      ),
    );

  Api._internal();

  static final _singleton = Api._internal();

  factory Api() => _singleton;

  Future<TimeWeather> getWeather({
    required double latitude,
    required double longitude,
  }) async {
    logInfo('1111');
    try {
      final uri = Uri.parse('https://api.openweathermap.org/data/2.5/weather' +
          '?lat=$latitude&lon=$longitude&appid=8b06f7a92d32f24e637b47f97a25ca06');

      final response = await http.get(uri);

      // final response = await dio.get(
      //   'https://api.openweathermap.org/data/2.5/weather',
      //   options: Options(
      //     headers: {
      //       'Content-Type': 'application/json',
      //       'Accept': 'application/json',
      //     },
      //   ),
      //   queryParameters: {
      //     'lat': latitude,
      //     'lon': longitude,
      //     'appid': '8b06f7a92d32f24e637b47f97a25ca06',
      //   },
      // );

      logInfo('2222: $response');
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;

      final weather = ResponseWeather.fromJson(data);

      final temperatureInFahrenheit = weather.main.temp;
      final temperatureInCelsius = (temperatureInFahrenheit - 32) / 5 ~/ 9;
      return TimeWeather(
        temperatureInCelsius: 25, //temperatureInCelsius,
        dateTime: DateTime.now(),
      );
    } catch (error) {
      print('error = $error');
      rethrow;
    }
  }
}
