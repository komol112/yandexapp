import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import 'package:yandex/presentation/widgets/custom_taxi_column.dart';
import 'package:yandex/presentation/widgets/custom_taxi_row.dart';
import 'package:yandex/presentation/widgets/custom_taxi_column_and_row.dart';
import 'package:yandex/presentation/blocs/map_bloc.dart';
import 'package:yandex/presentation/blocs/map_event.dart';
import 'package:yandex/presentation/blocs/map_state.dart';

class CartaScreen extends StatefulWidget {
  const CartaScreen({super.key});

  @override
  State<CartaScreen> createState() => _CartaScreenState();
}

class _CartaScreenState extends State<CartaScreen> {
  GoogleMapController? mapController;
  LatLng? currentPosition;
  LatLng? selectedPosition;

  bool isScrolling = false;
  bool isLoadingAddress = false;
  String currentAddress = "";

  Set<Polyline> polylines = {};

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      log("Location services are disabled.");
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        log("Location permissions are denied");
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      log(
        "Location permissions are permanently denied, we cannot request permissions.",
      );
      return false;
    }

    return true;
  }

  Future<void> getCurrentLocation() async {
    final hasPermission = await handleLocationPermission();
    if (!hasPermission) {
      log("location permission yo‘q");
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
    );

    currentPosition = LatLng(position.latitude, position.longitude);
    selectedPosition = currentPosition;

    manzlOlish(position.latitude, position.longitude);
    setState(() {});
  }

  Future<void> manzlOlish(double lat, double lng) async {
    setState(() {
      isLoadingAddress = true;
      currentAddress = "";
    });

    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        String name = place.street ?? "";
        String subLocality = place.subLocality ?? "";
        String locality = place.locality ?? "";

        setState(() {
          currentAddress = "$name, $subLocality, $locality".replaceAll(
            RegExp(r'^, | , '),
            '',
          );
          if (currentAddress.isEmpty) currentAddress = "Nomalm hudud";
        });
      }
    } catch (e) {
      setState(() {
        currentAddress = "Manzzil olishda xatolik !!!";
      });
    } finally {
      setState(() {
        isLoadingAddress = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (currentPosition == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onTap: (argument) {
              setState(() {
                isScrolling = !isScrolling;
              });
            },
            initialCameraPosition: CameraPosition(
              target: currentPosition!,
              zoom: 16,
            ),
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,

            polylines: polylines,

            onCameraMove: (pos) {
              selectedPosition = pos.target;

              if (!isScrolling) {
                setState(() => isScrolling = true);
              }
            },
            onCameraIdle: () {
              setState(() => isScrolling = false);

              if (selectedPosition != null) {
                manzlOlish(
                  selectedPosition!.latitude,
                  selectedPosition!.longitude,
                );
              }
            },
            onMapCreated: (controller) => mapController = controller,
          ),

          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedContainer(
                  padding: const EdgeInsets.all(5),
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),

                  child: buildAddressWidget(
                    currentAddress: currentAddress,
                    isLoadingAddress: isLoadingAddress,
                    isScrolling: isScrolling,
                  ),
                ),
                AnimatedPadding(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOut,
                  padding: EdgeInsets.only(bottom: isScrolling ? 40 : 10),
                  child: const Icon(
                    Icons.location_pin,
                    size: 40,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                if (currentPosition != null && selectedPosition != null) {
                  context.read<MapBloc>().add(
                    FetchRouteEvent(
                      start: currentPosition!,
                      end: selectedPosition!,
                    ),
                  );
                }
              },
              child: AnimatedContainer(
                padding: EdgeInsets.all(10),
                duration: Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 10,
                      spreadRadius: 5,
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    isScrolling
                        ? CustomTaxiRow()
                        : CustomTAxiColumnAndRow(
                            currentAddress: currentAddress,
                          ),
                  ],
                ),
              ),
            ),
          ),

          BlocListener<MapBloc, MapState>(
            listener: (context, state) {
              if (state is MapRouteLoadedState) {
                polylines.clear();

                polylines.add(
                  Polyline(
                    polylineId: PolylineId("route"),
                    points: state.points,
                    width: 6,
                    color: Colors.blue,
                  ),
                );

                setState(() {});
              }
            },
            child: SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
