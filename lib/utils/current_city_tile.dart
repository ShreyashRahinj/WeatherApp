import 'package:flutter/material.dart';

class CurrentyCityTile extends StatelessWidget {
  final String currentCityName;
  final String currentTemperature;
  final String description;
  final String time;
  final Image image;
  const CurrentyCityTile(
      {super.key,
      required this.currentCityName,
      required this.currentTemperature,
      required this.description,
      required this.time,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color.fromRGBO(227, 239, 248, 1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      currentCityName,
                      style: const TextStyle(
                        color: Color.fromRGBO(141, 152, 173, 1),
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '$currentTemperature\u00b0 C',
                      style: const TextStyle(
                        color: Color.fromRGBO(0, 23, 95, 1),
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Image(image: image.image),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: Text(
                description,
                style: const TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 1),
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: Text(
                time,
                style: const TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 1),
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
