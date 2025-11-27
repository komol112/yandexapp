import 'package:flutter/material.dart';

class PersonContainer extends StatelessWidget {
  const PersonContainer({super.key, required this.isScrolling});

  final bool isScrolling;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.yellow,
      ),
      child: Center(child: Icon(Icons.person_pin, size: 30)),
    );
  }
}
