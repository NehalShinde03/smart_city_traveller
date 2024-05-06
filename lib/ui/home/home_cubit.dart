import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_city_traveller/ui/home/home_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeCubit extends Cubit<HomeState>{
  HomeCubit(super.initialState);

  void initSharedPreferences() async{
    print("enter");
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    emit(state.copyWith(
        userInfo: preferences.getStringList('userInfo'),
        sourceAddress: preferences.getString('from') ?? "",
        destinationAddress: preferences.getString('to') ?? "",
    ));
    print("cubit exe");
    print("cubit s a ====> ${preferences.getString('from')}");
    print("cubit d a ====> ${preferences.getString('to')}");
  }


  /// fetch current location
  void fetchCurrentLocation() async{
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high
    );
    final GoogleMapController controller = await state.googleMapController.future;
    emit(state.copyWith(latLag: LatLng(position.latitude, position.longitude)));
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 15.0,
            bearing: 0.0
        ),
    ));

    List<Placemark> placeMarks = List.from(await placemarkFromCoordinates(position.latitude, position.longitude));
    Placemark placemark = placeMarks[0];
    String address = "${placemark.street}, ${placemark.name}, ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.postalCode}, ${placemark.country}";
    emit(state.copyWith(address: address));

    print("addreess ====> ${placeMarks}");
  }

// 204, 204, surat, gujarat, 395008, india

}