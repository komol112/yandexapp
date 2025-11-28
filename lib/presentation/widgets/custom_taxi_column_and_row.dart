import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yandex/presentation/blocs/reoute_bloc/map_bloc.dart';
import 'package:yandex/presentation/blocs/reoute_bloc/map_event.dart';
import 'package:yandex/presentation/screens/place_search.dart';
import 'package:yandex/presentation/widgets/custom_taxi_row.dart';
import 'package:yandex/presentation/widgets/custom_location.dart';

class CustomTAxiColumnAndRow extends StatefulWidget {
  final String currentAddress;
  final LatLng currentPosition; // foydalanuvchining hozirgi joyi
  final GoogleMapController? mapController;

  const CustomTAxiColumnAndRow({
    super.key,
    required this.currentAddress,
    required this.currentPosition,
    required this.mapController,
  });

  @override
  State<CustomTAxiColumnAndRow> createState() => _CustomTAxiColumnAndRowState();
}

class _CustomTAxiColumnAndRowState extends State<CustomTAxiColumnAndRow> {
  LatLng? selectedPosition;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        CustomTaxiRow(),
        SizedBox(
          height: 45,
          child: TextField(
            readOnly: true,
            onTap: () async {
              final latLng = await showSearch<LatLng?>(
                context: context,
                delegate: PlaceSearchDelegate(),
              );

              if (latLng != null) {
                setState(() => selectedPosition = latLng);

                // ignore: use_build_context_synchronously
                context.read<MapBloc>().add(
                  FetchRouteEvent(
                    start: widget.currentPosition,
                    end: selectedPosition!,
                  ),
                );

                // Map markazini yangilash
                widget.mapController!.animateCamera(
                  CameraUpdate.newLatLngZoom(selectedPosition!, 16),
                );
              }
            },
            decoration: InputDecoration(
              hintText: widget.currentAddress,
              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        CustomLocationNameRowWidget(currentAddress: widget.currentAddress),
        Divider(),
        CustomLocationNameRowWidget(currentAddress: widget.currentAddress),
        SizedBox(height: 50),
      ],
    );
  }
}
