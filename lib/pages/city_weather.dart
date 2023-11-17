import 'package:flutter/material.dart';

class CityWeather extends StatefulWidget {
  const CityWeather({super.key});

  @override
  State<CityWeather> createState() => _CityWeatherState();
}

class _CityWeatherState extends State<CityWeather> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    'City',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Container(
                    child: Stack(children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          height: 100,
                          width: 100,
                          color: Colors.black,
                        ),
                      ),
                      Align(
                          alignment: Alignment.center,
                          child: Container(
                            child: Text(
                              'Temp',
                              style: TextStyle(
                                color: Colors.yellow,
                                fontWeight: FontWeight.bold,
                                fontSize: 75,
                              ),
                            ),
                          )),
                      Align(alignment: Alignment.center,
                      child: Container(
                        child: Text('H :'),
                      ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          height: 150,
                          width: 50,
                          color: Colors.deepOrange,
                        ),
                      )
                    ]),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),

            Column(
              children: [
                Align(alignment: Alignment.center,
                child: Container(
                  height: 50,
                  width: 350,
                  color: Colors.green,
                ),)
              ],
            ),

            SizedBox(height: 20,),

            Column(
              children: [
                Align(alignment: Alignment.centerLeft,
                  child: Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.brown,
                  ),
                )
              ],
            ),

            SizedBox(height: 25,),

            Column(
              children: [
                Align(alignment: Alignment.center,
                child: Container(
                  height: 176,
                  width: 385,
                  color: Colors.pink,
                ),)
              ],
            )
          ],
        ),
        
      ),
    );
  }
}
