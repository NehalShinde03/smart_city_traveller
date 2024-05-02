import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class SearchState extends Equatable {
  final TextEditingController sourceAddressController;
  final TextEditingController destinationAddressController;
  final String address;
  // final LatLng latLng;

  const SearchState({
    required this.sourceAddressController,
    required this.destinationAddressController,
    this.address = ""
    // required this.latLng
  });

  @override
  List<Object?> get props =>
      [sourceAddressController, destinationAddressController, address /*latLng*/,];

  SearchState copyWith({
    TextEditingController? sourceAddressController,
    TextEditingController? destinationAddressController,
    String? address,
    /*LatLng? latLng*/
  }) {
    return SearchState(
        sourceAddressController: sourceAddressController ?? this.sourceAddressController,
        destinationAddressController: destinationAddressController ?? this.destinationAddressController,
        address: address ?? this.address
        // latLng: latLng ?? this.latLng
    );
    }
}
