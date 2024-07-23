import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_city_traveller/ui/search/search_state.dart';
import 'package:http/http.dart' as http;

class SearchCubit extends Cubit<SearchState>{
  SearchCubit(super.initialState);

  /// store current address
  void setSourceAddress(){
      state.sourceAddressController.value = TextEditingValue(text: state.address);
      emit(state.copyWith(sourceAddressController: state.sourceAddressController));
  }

  void generateSessionKey({required String sessionKey}){
    emit(state.copyWith(sessionToken: sessionKey));
  }

  /// which search textfield enabled
  void searchTextFieldEnable({required int textFieldEnable}){
    emit(state.copyWith(textFieldEnable: textFieldEnable));
  }

  /// clear place list
  void clearList(){
    emit(state.copyWith(placeList: []));
    isPlaceListIsEmpty(isPlaceListEmpty: false);
    print("place list length ===> ${state.placeList.length}");
  }

  /// if false show "search please" otherwise show "list of location"
  void isPlaceListIsEmpty({required bool isPlaceListEmpty}){
    emit(state.copyWith(isPlaceListEmpty: isPlaceListEmpty));
    print("cubit isPlaceEmpty =====> ${state.isPlaceListEmpty}");
  }

  /// search location on map|
  void searchLocation({required String searchLocation})async{
    String kPLACE_API_KEY = "AIzaSyDQ2c_pOSOFYSjxGMwkFvCVWKjYOM9siow";
    String baseUrl = "https://maps.googleapis.com/maps/api/place/autocomplete/json";
    String request = "$baseUrl?input=$searchLocation&key=$kPLACE_API_KEY";
    // String request = "$baseUrl?input=$searchLocation&key=$kPLACE_API_KEY&sessiontoken=${state.sessionToken}";
    final response = await Dio().get(request);
    if(response.statusCode == 200){
      List placeList = List.from(response.data['predictions']);
      final lat =response.data['lat'];
      emit(state.copyWith(placeList: placeList));
      print("place ======> ${state.placeList}");
      print("lat ======> $lat");
    }
  }

  ///set textField text
  void setTextFieldText({required String location}){
    if(state.textFieldEnable == 1){
      state.sourceAddressController.value = TextEditingValue(text: location);
      emit(state.copyWith(sourceAddressController: state.sourceAddressController));
    }else{
      state.destinationAddressController.value = TextEditingValue(text: location);
      emit(state.copyWith(destinationAddressController: state.destinationAddressController));
    }
  }

}



///place api :: AIzaSyCXb3JSLUgurnIUOgtB599ncur-Mvja5a5
///https://console.cloud.google.com/welcome/new?project=big-station-421712
///ok