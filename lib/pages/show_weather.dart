import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_report/components/api.dart';
import 'package:weather_report/components/horizontal_card.dart';
import 'package:weather_report/components/vertical_card.dart';
import 'package:weather_report/models/day_weather.dart';
import 'package:weather_report/models/time_weather.dart';
import 'package:permission_handler/permission_handler.dart';

class ShowWeather extends StatefulWidget {
  const ShowWeather({super.key});

  @override
  State<ShowWeather> createState() => _ShowWeatherState();
}

class _ShowWeatherState extends State<ShowWeather> {
  final Api _apiService = Api();
  final List<TimeWeather> weathers = List.generate(
    24,
    (index) => TimeWeather(
      temperatureInCelsius: 20 + Random().nextInt(10),
      dateTime: DateTime.now().add(Duration(hours: index)),
    ),
  );
  bool isCelsius = true;

  final List<DayClimate> dayclimates = [
    DayClimate(
      climate: Climate.cloudy,
      title: 'Cloudy',
      date: DateTime.now(),
    ),
    DayClimate(
      climate: Climate.sunny,
      title: 'Sunny',
      date: DateTime.now(),
    ),
    DayClimate(
      climate: Climate.dayrainy,
      title: 'Rainy',
      date: DateTime.now(),
    ),
    DayClimate(
      climate: Climate.dayrainy,
      title: 'Rainy',
      date: DateTime.now(),
    ),
    DayClimate(
      climate: Climate.sunny,
      title: 'Sunny',
      date: DateTime.now(),
    ),
    DayClimate(
      climate: Climate.windy,
      title: 'Windy',
      date: DateTime.now(),
    ),
    DayClimate(
      climate: Climate.dayrainy,
      title: 'Rainy',
      date: DateTime.now(),
    ),
  ];

  TimeWeather? currentWeather;

  @override
  void initState() {
    super.initState();
    _getCurrentWeather();
  }

  Future<Position> _getCurrentLocation() async {
    await Permission.location.request();
    final Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    print('position $position');
    return position;
  }

  Future<void> _getCurrentWeather() async {
    final position = await _getCurrentLocation();
    final weather = await _apiService.getWeather(
      latitude: position.latitude,
      longitude: position.longitude,
    );
    print('weather $weather');
    setState(() {
      currentWeather = weather;
    });
  }

  @override
  Widget build(BuildContext context) {
    final nowTemperature = currentWeather?.temperatureInCelsius;
    final String displayedTemperature;
    if (nowTemperature != null) {
      displayedTemperature = isCelsius
          ? nowTemperature.toString()
          : ((nowTemperature * 9 / 5) + 32).toStringAsFixed(0);
    } else {
      displayedTemperature = '??';
    }

    return Scaffold(
      // appBar: AppBar(),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Color.fromARGB(255, 0, 112, 204),
                Color.fromARGB(255, 165, 198, 255),
              ]),
        ),
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 80,
              ),
              //Search City Bar
              SearchBar(),

              const SizedBox(
                height: 16,
              ),

              const Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'CITY',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 200,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          Image.asset(
                            'assets/images/sunny.png',
                            width: 125,
                            height: 125,
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: const EdgeInsets.only(
                          left: 50,
                        ),
                        child: RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 100,
                            ),
                            children: [
                              TextSpan(
                                text: '$displayedTemperature°',
                              ),
                              TextSpan(
                                text: isCelsius ? ' C' : ' F',
                                style: const TextStyle(
                                  fontSize: 25,
                                ), // Font size for the decimal part
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 50,
                              height: 65,
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    isCelsius = true;
                                  });
                                },
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(32),
                                        topRight: Radius.circular(32),
                                      ),
                                      side: BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    const Color.fromARGB(255, 255, 255, 255),
                                  ),
                                ),
                                child: const Text(
                                  '°C',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                            Container(
                              width: 50,
                              height: 65,
                              child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      isCelsius = false;
                                    });
                                  },
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(32),
                                          bottomRight: Radius.circular(32),
                                        ),
                                        side: BorderSide(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                      const Color.fromARGB(255, 255, 255, 255),
                                    ),
                                  ),
                                  child: const Text(
                                    '°F',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.black),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Container(
                      child: const Text(
                        'H :',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: const Text(
                        'L :',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 20,
              ),

              Container(
                height: 65,
                width: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Color.fromARGB(82, 255, 255, 255),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Icon(Icons.water_drop_outlined),
                    Text(
                      '   HUMIDITY',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              HorizontalCard(
                weathers: weathers,
              ),

              const SizedBox(
                height: 25,
              ),

              VerticalCard(
                dayclimates: dayclimates,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
