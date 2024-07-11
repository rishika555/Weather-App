import 'package:flutter/material.dart';

class WeatherData extends StatelessWidget {
    final String index1, index2, value1, value2;
    const WeatherData({super.key, required this.index1, required this.index2, required this.value1, required this.value2});

    @override
    Widget build(BuildContext context) {
        return Column(
            children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                        Text(
                            index1,
                            style: const TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 24,
                            ),
                        ),
                        Text(
                            index2,
                            style: const TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                            ),
                        ),
                    ],
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                        Text(
                            value1,
                            style: const TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                                fontSize: 20,
                            ),
                        ),
                        Text(
                            value2,
                            style: const TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                                fontSize: 20,
                            ),
                        ),
                    ],
                ),
            ],
        );
    }
}
