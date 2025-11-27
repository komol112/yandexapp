
  import 'package:flutter/material.dart';
import 'package:yandex/presentation/widgets/person_container.dart';

Widget buildAddressWidget({required bool isScrolling, required bool isLoadingAddress, required String currentAddress}) {
    if (isScrolling) {
      return const PersonContainer(isScrolling: true);
    }

    if (isLoadingAddress) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          PersonContainer(isScrolling: false),
          SizedBox(width: 5),
          SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
          SizedBox(width: 5),
        ],
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const PersonContainer(isScrolling: false),
        const SizedBox(width: 5),
        SizedBox(
          width: 180,
          child: Text(
            currentAddress.isEmpty ? "Manzil topilmadi" : currentAddress,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ),
      ],
    );
  }