import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class SearchState extends Equatable {
  final TextEditingController sourceAddressController;
  final TextEditingController destinationAddressController;
  final String address;
  final Uuid uuid;
  final String sessionToken;
  final List placeList;
  final bool isPlaceListEmpty;
  final int textFieldEnable;
  // final LatLng latLng;

  const SearchState({
    required this.sourceAddressController,
    required this.destinationAddressController,
    this.address = "",
    this.uuid = const Uuid(),
    this.sessionToken = "056a8f46-88b8-4a93-ae1b-1b7b391b2733",
    this.placeList = const [],
    this.isPlaceListEmpty = false,
    this.textFieldEnable = 0,
    // required this.latLng
  });

  @override
  List<Object?> get props => [
        sourceAddressController,
        destinationAddressController,
        address /*latLng*/,
        uuid,
        sessionToken,
        placeList,
        isPlaceListEmpty,
        textFieldEnable
      ];

  SearchState copyWith({
    TextEditingController? sourceAddressController,
    TextEditingController? destinationAddressController,
    String? address,
    Uuid? uuid,
    String? sessionToken,
    List? placeList,
    bool? isPlaceListEmpty,
    int? textFieldEnable
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
        placeList: placeList ?? this.placeList,
        isPlaceListEmpty: isPlaceListEmpty ?? this.isPlaceListEmpty,
        textFieldEnable : textFieldEnable ?? this.textFieldEnable
        // latLng: latLng ?? this.latLng
        );
  }
}
