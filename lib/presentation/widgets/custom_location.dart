
import 'package:flutter/material.dart';

class CustomLocationNameRowWidget extends StatelessWidget {
  const CustomLocationNameRowWidget({super.key, required this.currentAddress});

  final String currentAddress;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.shade100,
          ),
          child: Icon(Icons.location_on_outlined, size: 30),
        ),
        SizedBox(
          width: 220,
          child: Text(
            maxLines: 2,
            currentAddress,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}
