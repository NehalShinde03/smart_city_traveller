import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeState extends Equatable {
  final List<String> userInfo;
  // final List<IconData> drawerItemIcon;
  final TextEditingController searchController;
  // final bool isDirectionIconClick;
  final Completer<GoogleMapController> googleMapController;
  final String address;
  final LatLng latLag;
  final String sourceAddress;
  final String destinationAddress;
  final Set<Polyline> setPolyLine;
  final Set<Marker> setMarkers;
  final String mapTopBarValue;
  final List listOfCoordinates;

  const HomeState({
    this.userInfo = const [],
    // this.drawerItemIcon = const [Icons.home, Icons.settings, Icons.contact_emergency,],
    required this.searchController,
    // this.isDirectionIconClick = false,
    required this.googleMapController,
    this.address = "",
    required this.latLag,
    this.sourceAddress = "",
    this.destinationAddress = "",
    this.setPolyLine = const {},
    this.setMarkers = const {},
    this.mapTopBarValue = "0",
    this.listOfCoordinates = const []
  });

  @override
  List<Object?> get props => [
        userInfo,
        // drawerItemIcon,
        searchController,
        // isDirectionIconClick,
        googleMapController,
        address,
        latLag,
        sourceAddress,
        destinationAddress,
        setPolyLine,
        setMarkers,
        mapTopBarValue,
        listOfCoordinates
      ];

  HomeState copyWith({
    List<String>? userInfo,
    // List<IconData>? drawerItemIcon,
    TextEditingController? searchController,
    Future<PermissionStatus>? permissionStatus,
    // bool? isDirectionIconClick,
    Completer<GoogleMapController>? googleMapController,
    String? address,
    LatLng? latLag,
    String? sourceAddress,
    String? destinationAddress,
    Set<Polyline>? setPolyLine,
    Set<Marker>? setMarkers,
    String? mapTopBarValue,
    List? listOfCoordinates
  }) {
    return HomeState(
      userInfo: userInfo ?? this.userInfo,
      // drawerItemIcon: drawerItemIcon ?? this.drawerItemIcon,
      searchController: searchController ?? this.searchController,
      // isDirectionIconClick: isDirectionIconClick ?? this.isDirectionIconClick,
      googleMapController: googleMapController ?? this.googleMapController,
      address: address ?? this.address,
      latLag: latLag ?? this.latLag,
      sourceAddress: sourceAddress ?? this.sourceAddress,
      destinationAddress: destinationAddress ?? this.destinationAddress,
      setPolyLine: setPolyLine ?? this.setPolyLine,
      setMarkers: setMarkers ?? this.setMarkers,
      mapTopBarValue: mapTopBarValue ?? this.mapTopBarValue,
      listOfCoordinates: listOfCoordinates ?? this.listOfCoordinates
    );
  }
}

//ok