import 'package:flutter/material.dart';
import 'package:weather_report/models/time_weather.dart';

class HorizontalCard extends StatelessWidget {
  final List<TimeWeather> weathers;
  const HorizontalCard({
    super.key,
    required this.weathers,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color.fromARGB(170, 68, 112, 255),),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 160,
      child: ListView.builder(
        itemCount: weathers.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(80, 255, 255, 255),
              ),
              width: 110,
              child: ListTile(
                title: Text(weathers[index].dateTime.hour.toString()),
              ),
            ),
          );
        },
      ),
    );
  }
}
