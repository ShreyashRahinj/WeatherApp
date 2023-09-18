import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather/pages/city_forecast_page.dart';
import 'package:weather/services/location_services.dart';
import 'package:weather/services/weather_api.dart';
import 'package:weather/utils/current_city_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController search;
  String searchCity = "Pune";
  bool isEnable = true;

  @override
  void initState() {
    super.initState();
    search = TextEditingController();
    checkPosition();
  }

  void checkPosition() async {
    try {
      await determinePosition();
      isEnable = true;
    } on Exception catch (_) {
      isEnable = false;
    }
  }

  void onClickSearch() async {
    try {
      await Provider.of<WeatherMapApi>(context, listen: false)
          .fetchSelectedCityData(search.text);
      setState(() {
        searchCity = search.text;
        search.clear();
      });
    } on Exception catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return isEnable
        ? Consumer<WeatherMapApi>(
            builder: (context, value, child) => SafeArea(
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: const Color.fromRGBO(251, 253, 255, 1),
                body: ListView(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              const Expanded(
                                flex: 3,
                                child: Text(
                                  'Good Morning',
                                  style: TextStyle(
                                    color: Color.fromRGBO(0, 0, 0, 1),
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color.fromRGBO(251, 223, 136, 1),
                                  ),
                                  child: const Icon(
                                    Icons.person,
                                    size: 50,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              DateFormat.MMMMEEEEd().format(DateTime.now()),
                            ),
                          ),
                        ],
                      ),
                    ),
                    FutureBuilder(
                      future: value.fetchCurrentLocationData(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final weatherData = snapshot.data!;

                          return CurrentyCityTile(
                            image: Image.asset(
                                "assets/images/${weatherData['list'][0]['weather'][0]['icon']}.png"),
                            currentCityName: 'Current Location',
                            currentTemperature:
                                (weatherData['list'][0]['main']['temp'] - 273.5)
                                    .toString()
                                    .substring(0, 5),
                            description: weatherData['list'][0]['weather'][0]
                                ['description'],
                            time: DateFormat.Hm().format(DateTime.now()),
                          );
                        } else {
                          return const Text(
                              'Please enable location permissions from settings to get weather data of current location and restart the app');
                        }
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Center(
                      child: IconButton(
                          onPressed: () => setState(() {}),
                          icon: const Icon(Icons.refresh)),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextField(
                      controller: search,
                      decoration: InputDecoration(
                        prefixIcon: GestureDetector(
                          onTap: onClickSearch,
                          child: const Icon(Icons.search),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    FutureBuilder(
                      future: Provider.of<WeatherMapApi>(context, listen: false)
                          .fetchSelectedCityData(searchCity),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final weatherData = snapshot.data!;
                          if (weatherData.isEmpty) {
                            return const Text('Sorry Wrong City');
                          } else {
                            return GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CityForecastPage(
                                    image: Image.asset(
                                        "assets/images/${weatherData['weather'][0]['icon']}.png"),
                                    cityName: searchCity,
                                    humidity: weatherData['main']['humidity']
                                        .toString(),
                                    description: weatherData['weather'][0]
                                        ['description'],
                                    temperature:
                                        (weatherData['main']['temp'] - 273.5)
                                            .toString()
                                            .substring(0, 5),
                                    windSpeed:
                                        weatherData['wind']['speed'].toString(),
                                  ),
                                ),
                              ),
                              child: CurrentyCityTile(
                                image: Image.asset(
                                    "assets/images/${weatherData['weather'][0]['icon']}.png"),
                                currentCityName: weatherData['name'],
                                currentTemperature:
                                    (weatherData['main']['temp'] - 273.5)
                                        .toString()
                                        .substring(0, 5),
                                description: weatherData['weather'][0]
                                    ['description'],
                                time: '',
                              ),
                            );
                          }
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          )
        : const Scaffold(
            body: Center(
              child: Text('Please enable location permissions from settings'),
            ),
          );
  }
}
