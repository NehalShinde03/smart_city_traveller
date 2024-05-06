import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_city_traveller/common/common_colors.dart';
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

    if(state.sourceAddress.isNotEmpty && state.destinationAddress.isNotEmpty){
      print("source address ----> ${state.sourceAddress}");
      print("destination address ----> ${state.destinationAddress}");
      final convertAddressToCoordinates = await locationFromAddress(state.sourceAddress);
      LatLng latLng = LatLng(convertAddressToCoordinates.last.latitude, convertAddressToCoordinates.last.longitude);
      emit(state.copyWith(latLag: latLng));
      addPolyLine();
    }else{
      fetchCurrentLocation();
    }

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
    Placemark placeMark = placeMarks[0];
    String address = "${placeMark.street}, ${placeMark.name}, ${placeMark.locality}, ${placeMark.administrativeArea}, ${placeMark.postalCode}, ${placeMark.country}";
    emit(state.copyWith(address: address));

    print("addreess ====> ${placeMarks}");
  }


  void setTopBar({required int topBarValue}){
    emit(state.copyWith(topBarValue: topBarValue));
  }

  /// add polyLine
  Future<void> addPolyLine() async {
    final convertAddressToCoordinates = await locationFromAddress(state.destinationAddress);
    final destination = LatLng(convertAddressToCoordinates.last.latitude, convertAddressToCoordinates.last.longitude);
    List<LatLng> polyLineCoordinates = [state.latLag, destination];

    print("point 1 ====> ${state.latLag}");
    print("point 2 ====> $destination");

    Polyline polyline = Polyline(
        polylineId: const PolylineId("poly"),
        points: polyLineCoordinates,
        width: 5,
        color: CommonColor.blue
    );

    Set<Polyline> setPolyLine = {polyline};
    // setPolyLine.add(polyline);
    emit(state.copyWith(setPolyLine: setPolyLine));

    // GoogleMapController googleMapController = await state.googleMapController.future;
    // googleMapController.animateCamera(
    //   CameraUpdate.newLatLngBounds(
    //     LatLngBounds(
    //         southwest: destination,
    //         northeast: source,
    //     ), 50
    //   )
    // );
  }


// 204, 204, surat, gujarat, 395008, india

}