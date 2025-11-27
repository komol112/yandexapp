import 'package:flutter/material.dart';
import 'package:yandex/presentation/widgets/custom_taxi_row.dart';
import 'package:yandex/presentation/widgets/custom_location.dart';

class CustomTAxiColumnAndRow extends StatelessWidget {
  const CustomTAxiColumnAndRow({super.key, required this.currentAddress});

  final String currentAddress;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        CustomTaxiRow(),

        SizedBox(
          height: 45,
          child: TextField(
            decoration: InputDecoration(
              hintText: "We here to ?",
              hintStyle: TextStyle(fontSize: 18),

              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        CustomLocationNameRowWidget(currentAddress: currentAddress),
        Divider(),

        CustomLocationNameRowWidget(currentAddress: currentAddress),

        SizedBox(height: 50),
      ],
    );
  }
}
