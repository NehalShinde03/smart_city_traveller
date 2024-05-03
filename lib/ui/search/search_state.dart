import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class SearchState extends Equatable {
  final TextEditingController sourceAddressController;
  final TextEditingController destinationAddressController;
  final String address;
  final Uuid uuid;
  final String sessionToken;
  final List<String> placeList;
  // final LatLng latLng;

  const SearchState({
    required this.sourceAddressController,
    required this.destinationAddressController,
    this.address = "",
    this.uuid = const Uuid(),
    this.sessionToken = "122344",
    this.placeList = const []
    // required this.latLng
  });

  @override
  List<Object?> get props => [
        sourceAddressController,
        destinationAddressController,
        address /*latLng*/,
        uuid,
        sessionToken,
        placeList
      ];

  SearchState copyWith({
    TextEditingController? sourceAddressController,
    TextEditingController? destinationAddressController,
    String? address,
    Uuid? uuid,
    String? sessionToken,
    List<String>? placeList
    /*LatLng? latLng*/
  }) {
    return SearchState(
        sourceAddressController:
            sourceAddressController ?? this.sourceAddressController,
        destinationAddressController:
            destinationAddressController ?? this.destinationAddressController,
        address: address ?? this.address,
        uuid: uuid ?? this.uuid,
        sessionToken: sessionToken ?? this.sessionToken,
        placeList: placeList ?? this.placeList
        // latLng: latLng ?? this.latLng
        );
  }
}
