import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
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
        mapTopBarValue: preferences.getString('mapTopBarValue')
    ));
    // if(state.sourceAddress.isNotEmpty && state.destinationAddress.isNotEmpty){
    //   print("source address ----> ${state.sourceAddress}");
    //   print("destination address ----> ${state.destinationAddress}");
    //   final convertAddressToCoordinates = await locationFromAddress(state.sourceAddress);
    //   LatLng latLng = LatLng(convertAddressToCoordinates.last.latitude, convertAddressToCoordinates.last.longitude);
    //   emit(state.copyWith(latLag: latLng));
    //   addPolyLine();
    // }else{
    //   fetchCurrentLocation();
    // }
  }


  /// fetch current location
/*  void fetchCurrentLocation() async{
    try{
      Geolocator.getPositionStream(
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.high)
      ).listen((Position? position) async {
        if(position!=null){
          emit(state.copyWith(latLag: LatLng(position.latitude, position.longitude)));
          final GoogleMapController controller = await state.googleMapController.future;
          controller.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
              target: state.latLag,
              zoom: 18.0,
            ),
          ));
          List<Placemark> placeMarks = List.from(await placemarkFromCoordinates(position.latitude, position.longitude));
          if(placeMarks.isNotEmpty){
            Placemark placeMark = placeMarks.first;
            String address = "${placeMark.street}, ${placeMark.name}, ${placeMark.locality}, ${placeMark.administrativeArea}, ${placeMark.postalCode}, ${placeMark.country}";
            emit(state.copyWith(address: address));
            print("addreess ====> ${address}");
          }
        }
      });
    }catch(e){
        print("fetch Current Location Exception ====> $e");
    }
  }*/


    void fetchCurrentLocation() async{
      try{
        // emit(state.copyWith(setMarkers: {}));
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high
        );
        final GoogleMapController controller = await state.googleMapController.future;
        emit(state.copyWith(latLag: LatLng(position.latitude, position.longitude)));
        controller.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 18.0,
          ),
        ));
        List<Placemark> placeMarks = List.from(await placemarkFromCoordinates(position.latitude, position.longitude));
        Placemark placeMark = placeMarks.first;
        String address = "${placeMark.street}, ${placeMark.name}, ${placeMark.locality}, ${placeMark.administrativeArea}, ${placeMark.postalCode}, ${placeMark.country}";
        emit(state.copyWith(
          address: address,
/*
          setMarkers: {
              Marker(
                markerId: const MarkerId('CurrentLocation_0'),
                icon: BitmapDescriptor.defaultMarker,
                position: state.latLag,
                infoWindow: InfoWindow(
                  title: state.address,
                ),
              )
          }
*/
        ));
      }catch(e){
        print("fetch current location exception =====> $e");
      }
  }

  /// if 0 - show TextField ---> 1 - From&To ------> 2 - countDown
  void setMapTopBarValue({required String topBarValue}) async{
    emit(state.copyWith(mapTopBarValue: topBarValue));
    SharedPreferences preference = await SharedPreferences.getInstance();
    preference.setString('mapTopBarValue', topBarValue);
    emit(state.copyWith(setMarkers: {}));
  }


  /// add polyLine
  Future<void> addPolyLine(String sourceAddress, String destinationAddress) async {
    print("add poly Line source =====> $sourceAddress");
    print("add poly Line destination =====> $destinationAddress");

    try{
      final convertSourceAddressToCoordinates = await locationFromAddress(sourceAddress);
      final convertDestinationAddressToCoordinates = await locationFromAddress(destinationAddress);

      final LatLng sourceAddressCoordinates = LatLng(convertSourceAddressToCoordinates.last.latitude, convertSourceAddressToCoordinates.last.longitude);
      final LatLng destinationAddressCoordinates = LatLng(convertDestinationAddressToCoordinates.last.latitude, convertDestinationAddressToCoordinates.last.longitude);
      List<LatLng> polyLineCoordinates = [sourceAddressCoordinates, destinationAddressCoordinates];

      print("point 1 ====> $sourceAddressCoordinates");
      print("point 2 ====> $destinationAddressCoordinates");

      // PolylinePoints polylinePoints = PolylinePoints();
      // List<LatLng> polylineCoordinates = [];
      // Map<PolylineId, Polyline> polyLine = {};
      //
      // PolylineResult polylineResult = await polylinePoints.getRouteBetweenCoordinates(
      //     "AIzaSyCGShAceyIm1LHL2mLja0eKCKDjoZV2RzY",
      //     PointLatLng(sourceAddressCoordinates.latitude, sourceAddressCoordinates.longitude),
      //     PointLatLng(destinationAddressCoordinates.latitude, destinationAddressCoordinates.longitude),
      // );
      //
      // if(polylineResult.points.isNotEmpty){
      //    polylineResult.points.map((e){
      //
      //    });
      // }
      getResponse(sourceAddressCoordinates, destinationAddressCoordinates);

      Polyline polyline = Polyline(
          polylineId: const PolylineId("poly"),
          points: polyLineCoordinates,
          width: 5,
          color: CommonColor.blue,
          geodesic: true,
      );

      emit(state.copyWith(
          setPolyLine: {polyline},
          listOfCoordinates: polyLineCoordinates,
          setMarkers: {
            Marker(
              markerId: const MarkerId('SourceLocation_0'),
              icon: BitmapDescriptor.defaultMarker,
              position: sourceAddressCoordinates,
              infoWindow: InfoWindow(
                title: sourceAddress,
              ),
            ),
            Marker(
              markerId: const MarkerId('destinationLocation_1'),
              position: destinationAddressCoordinates,
              infoWindow: InfoWindow(
                title: destinationAddress,
              ),
            )
          },
        ),
      );

      final GoogleMapController googleMapController = await state.googleMapController.future;
      googleMapController.animateCamera(
          CameraUpdate.newLatLngBounds(
              LatLngBounds(
                southwest: LatLng(
                    sourceAddressCoordinates.latitude <= destinationAddressCoordinates.latitude
                        ? sourceAddressCoordinates.latitude
                        : destinationAddressCoordinates.latitude,
                    sourceAddressCoordinates.longitude <= destinationAddressCoordinates.longitude
                        ? sourceAddressCoordinates.longitude
                        : destinationAddressCoordinates.longitude
                ),
                northeast: LatLng(
                    sourceAddressCoordinates.latitude <= destinationAddressCoordinates.longitude
                        ? destinationAddressCoordinates.latitude
                        : sourceAddressCoordinates.latitude,
                    sourceAddressCoordinates.longitude <= destinationAddressCoordinates.longitude
                        ? destinationAddressCoordinates.longitude
                        : sourceAddressCoordinates.longitude
                ),
              ), 149
          )
      );
    }catch(e){
      print("add Polyline ======> $e");
    }
  }



  getResponse(LatLng sourceAddressCoordinates, LatLng destinationAddressCoordinates) async{
      String request = "https://maps.googleapis.com/maps/api/directions/json?origin=${sourceAddressCoordinates.latitude}%2C-${sourceAddressCoordinates.longitude}&destination=${destinationAddressCoordinates.latitude}%2C-${destinationAddressCoordinates.longitude}&key=AIzaSyCGShAceyIm1LHL2mLja0eKCKDjoZV2RzY";
      // PolylineResult result = PolylinePoints.
      final response = await Dio().get(request);
      if(response.statusCode == 200){
        print("list of data =====? ${response.data}");
      }
  }

}


// 204, 204, surat, gujarat, 395008, india

/*[ERROR:flutter/runtime/dart_vm_initializer.cc(41)] Unhandled Exception: MissingPluginException(No implementation found for method camera#animate on channel plugins.flutter.dev/google_maps_android_0)
E/flutter (20139): #0      MethodChannel._invokeMethod (package:flutter/src/services/platform_channel.dart:332:7)
E/flutter (20139): <asynchronous suspension>*/

/// reduce padding of icon button
/// IconButton(
//                           onPressed: () => print("hello"),
//                           icon: const Icon(Icons.close, size: Spacing.large,),
//                           padding: PaddingValue.zero,
//                           constraints: BoxConstraints(),
//                           style: ButtonStyle(tapTargetSize: MaterialTapTargetSize.shrinkWrap),
//                       )


/*
* 0 = TextField
* 1 = Source and destination
* 2 = timer
*/
//ok
///AIzaSyAlGfqovveJyIrEKxA4D4s1VbAgBWc5GKA place
///AIzaSyCGShAceyIm1LHL2mLja0eKCKDjoZV2RzY direction
///https://blog.codemagic.io/creating-a-route-calculator-using-google-maps/