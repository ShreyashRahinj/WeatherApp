import 'package:flutter/material.dart';

class ForecastTile extends StatelessWidget {
  final String dateTime;
  final String description;
  final String temperature;
  final String rainChances;
  const ForecastTile(
      {super.key,
      required this.dateTime,
      required this.description,
      required this.temperature,
      required this.rainChances});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromRGBO(255, 255, 255, 1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color.fromRGBO(0, 23, 95, 1)),
        ),

        // width: 120,
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              dateTime.substring(0, 10),
            ),
            Text(
              dateTime.substring(10),
            ),
            Text(
              description,
              style: const TextStyle(
                color: Color.fromRGBO(0, 0, 0, 1),
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              temperature,
              style: const TextStyle(
                color: Color.fromRGBO(0, 23, 95, 1),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('Rain : $rainChances%'),
          ],
        ),
      ),
    );
  }
}
