import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/services/weather_api.dart';

import '../utils/forecast_tile.dart';

class CityForecastPage extends StatefulWidget {
  final String cityName;
  final String temperature;
  final String description;
  final String windSpeed;
  final String humidity;
  final Image image;
  const CityForecastPage(
      {super.key,
      required this.cityName,
      required this.temperature,
      required this.description,
      required this.windSpeed,
      required this.humidity,
      required this.image});

  @override
  State<CityForecastPage> createState() => _CityForecastPageState();
}

class _CityForecastPageState extends State<CityForecastPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<WeatherMapApi>(context, listen: false)
          .fetchSelectedCityForecast(widget.cityName),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data!;
          return SafeArea(
            child: Scaffold(
              backgroundColor: const Color.fromRGBO(99, 143, 237, 1),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.cityName,
                    style: const TextStyle(
                      color: Color.fromRGBO(227, 239, 248, 1),
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.description,
                    style: const TextStyle(
                      color: Color.fromRGBO(209, 229, 250, 1),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${widget.temperature}\u00b0 C',
                        style: const TextStyle(
                          color: Color.fromRGBO(209, 229, 250, 1),
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Image(image: widget.image.image),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            const Text(
                              'Speed of Wind',
                              style: TextStyle(
                                color: Color.fromRGBO(209, 229, 250, 1),
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Text(
                              '${widget.windSpeed} km/hr',
                              style: const TextStyle(
                                color: Color.fromRGBO(209, 229, 250, 1),
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Humidity',
                              style: TextStyle(
                                color: Color.fromRGBO(209, 229, 250, 1),
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Text(
                              '${widget.humidity}%',
                              style: const TextStyle(
                                color: Color.fromRGBO(209, 229, 250, 1),
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Future Weather',
                    style: TextStyle(
                      color: Color.fromRGBO(209, 229, 250, 1),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    // height: ,
                    height: 160,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: data['cnt'],
                      itemBuilder: (context, index) {
                        return ForecastTile(
                          dateTime: data['list'][index]['dt_txt'],
                          description: data['list'][index]['weather'][0]
                              ['description'],
                          rainChances:
                              data['list'][index]['clouds']['all'].toString(),
                          temperature:
                              data['list'][index]['main']['temp'].toString(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
