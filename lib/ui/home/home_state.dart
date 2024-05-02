import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeState extends Equatable {
  final List<String> userInfo;
  final List<IconData> drawerItemIcon;
  final TextEditingController searchController;
  final bool isDirectionIconClick;
  final Completer<GoogleMapController> googleMapController;

  const HomeState({
    this.userInfo = const [],
    this.drawerItemIcon = const [Icons.home, Icons.settings, Icons.contact_emergency,],
    required this.searchController,
    // required this.permissionStatus,
    this.isDirectionIconClick = false,
    required this.googleMapController
  });

  @override
  List<Object?> get props => [
        userInfo,
        drawerItemIcon,
        searchController,
       //  permissionStatus,
       isDirectionIconClick,
       googleMapController
      ];

  HomeState copyWith({
    List<String>? userInfo,
    List<IconData>? drawerItemIcon,
    TextEditingController? searchController,
    Future<PermissionStatus>? permissionStatus,
    bool? isDirectionIconClick,
    Completer<GoogleMapController>? googleMapController
  }) {
    return HomeState(
      userInfo: userInfo ?? this.userInfo,
      drawerItemIcon: drawerItemIcon ?? this.drawerItemIcon,
      searchController: searchController ?? this.searchController,
      // permissionStatus: permissionStatus ?? this.permissionStatus,
        isDirectionIconClick: isDirectionIconClick ?? this.isDirectionIconClick,
      googleMapController: googleMapController ?? this.googleMapController
    );
  }
}
