import 'package:flutter/material.dart';
class HourlyForecastItem extends StatelessWidget {
  final IconData icon;
  final String time;
  final String temperature;

  const HourlyForecastItem({super.key, required this.icon, required this.time, required this.temperature});

  @override
  Widget build(BuildContext context) {
    return   Card(
                        elevation: 6,
                        child: Container(
                          width: 100,
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              Text(
                                time,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Icon(
                                icon,
                                size: 34,
                              ),
                              SizedBox(height: 8),
                              Text(
                               temperature,
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
  }
}