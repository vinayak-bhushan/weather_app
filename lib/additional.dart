import 'package:flutter/material.dart';
class AdditionalinfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const AdditionalinfoItem({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon, size: 32,),
        SizedBox(height: 8),
        Text(label),
        Text(value,style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        ),

      ],
    );
  }
}