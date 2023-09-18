import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class WeatherMapApi extends ChangeNotifier {
  // Sample output
  // {"coord":{"lon":73.8553,"lat":18.5196},"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04d"}],"base":"stations","main":{"temp":296.42,"feels_like":297,"temp_min":296.42,"temp_max":296.42,"pressure":1007,"humidity":84,"sea_level":1007,"grnd_level":945},"visibility":10000,"wind":{"speed":4.15,"deg":263,"gust":9.84},"clouds":{"all":100},"dt":1694864489,"sys":{"country":"IN","sunrise":1694825548,"sunset":1694869626},"timezone":19800,"id":1259229,"name":"Pune","cod":200}

  var currentCityName = "Pune";
  var apiKey = '368733abeceaea593ceef7e51c434b6c';

  Future<Map<String, dynamic>> fetchCurrentLocationData() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      var lat = position.latitude;
      var lon = position.longitude;
      final res = await http.get(
        Uri.parse(
            'http://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&appid=$apiKey'),
        headers: {
          "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*'
        },
      );

      if (res.statusCode == 200) {
        return await jsonDecode(res.body);
      }
      return {};
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  Future<Map<String, dynamic>> fetchSelectedCityData(String cityName) async {
    try {
      final res = await http.get(
        Uri.parse(
            'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey'),
        headers: {
          "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*'
        },
      );

      if (res.statusCode == 200) {
        return await jsonDecode(res.body);
      }
      return {};
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  Future<Map<String, dynamic>> fetchSelectedCityForecast(
      String cityName) async {
    try {
      final res = await http.get(
        Uri.parse(
            'http://api.openweathermap.org/geo/1.0/direct?q=$cityName&appid=$apiKey'),
        headers: {
          "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*'
        },
      );

      if (res.statusCode == 200) {
        final data = await jsonDecode(res.body);
        var lat = data[0]['lat'];
        var lon = data[0]['lon'];

        final res2 = await fetchCityDetailedForecast(lat, lon);

        return res2;
      }
      return {};
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  Future<Map<String, dynamic>> fetchCityDetailedForecast(
      double lat, double lon) async {
// {
//   "cod": "200",
//   "message": 0,
//   "cnt": 40,
//   "list": [
//     {
//       "dt": 1661871600,
//       "main": {
//         "temp": 296.76,
//         "feels_like": 296.98,
//         "temp_min": 296.76,
//         "temp_max": 297.87,
//         "pressure": 1015,
//         "sea_level": 1015,
//         "grnd_level": 933,
//         "humidity": 69,
//         "temp_kf": -1.11
//       },
//       "weather": [
//         {
//           "id": 500,
//           "main": "Rain",
//           "description": "light rain",
//           "icon": "10d"
//         }
//       ],
//       "clouds": {
//         "all": 100
//       },
//       "wind": {
//         "speed": 0.62,
//         "deg": 349,
//         "gust": 1.18
//       },
//       "visibility": 10000,
//       "pop": 0.32,
//       "rain": {
//         "3h": 0.26
//       },
//       "sys": {
//         "pod": "d"
//       },
//       "dt_txt": "2022-08-30 15:00:00"
//     },

    try {
      final res = await http.get(
        Uri.parse(
            'http://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&appid=$apiKey'),
        headers: {
          "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*'
        },
      );

      if (res.statusCode == 200) {
        return await jsonDecode(res.body);
      }
      return {};
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}
