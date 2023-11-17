import 'package:flutter/material.dart';
import 'package:weather_report/climate_list/climate_item.dart';
import 'package:weather_report/models/day_weather.dart';

class VerticalCard extends StatelessWidget {
  const VerticalCard({
    super.key,
    required this.dayclimates,
  });

  final List<DayClimate> dayclimates;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color.fromARGB(170, 68, 112, 255),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 400,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: dayclimates.length,
        itemBuilder: (ctx, index) => Dismissible(
          key: ValueKey(dayclimates[index]),
          background: Container(
            // color: Theme.of(context).colorScheme.error.withOpacity(0.75),
            margin: EdgeInsets.symmetric(
              vertical: 16,
            ),
          ),
          child: ClimateItem(
            dayclimates[index],
          ),
        ),
      ),
    );
  }
}
