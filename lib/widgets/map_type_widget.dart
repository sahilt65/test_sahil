// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class MapTypeWidget extends StatelessWidget {
  String mapType;
  IconData icon;
  MapTypeWidget({
    Key? key,
    required this.mapType,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 8,
        ),
        Icon(
          icon,
          size: 23,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          mapType,
          style: const TextStyle(fontSize: 12),
        )
      ],
    );
  }
}
