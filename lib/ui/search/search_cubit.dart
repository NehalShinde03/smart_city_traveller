import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_city_traveller/ui/search/search_state.dart';

class SearchCubit extends Cubit<SearchState>{
  SearchCubit(super.initialState);

  void setSourceAddress(){
      state.sourceAddressController.value = TextEditingValue(text: state.address);
      emit(state.copyWith(sourceAddressController: state.sourceAddressController));
  }

  void generateSessionKey({required String sessionKey}){
    emit(state.copyWith(sessionToken: sessionKey));
  }

  void clearList(){
    emit(state.copyWith(placeList: []));
    print("place list length ===> ${state.placeList.length}");
  }

  /// search location on map
  void searchLocation({required String searchLocation})async{
    String kPLACE_API_KEY = "AIzaSyDQ2c_pOSOFYSjxGMwkFvCVWKjYOM9siow";
    String baseUrl = "https://maps.googleapis.com/maps/api/place/autocomplete/json";
    String request = "$baseUrl?input=$searchLocation&key=$kPLACE_API_KEY&sessiontoken=${state.sessionToken}";
    final response = await Dio().get(request);
    if(response.statusCode == 200){
      List placeList = List.from(response.data['predictions']);
      emit(state.copyWith(placeList: placeList));
      print("m place list length ===> ${state.placeList.length}");
    }else{
      print("something wrong");
    }
  }

}



///place api :: AIzaSyCXb3JSLUgurnIUOgtB599ncur-Mvja5a4
///https://console.cloud.google.com/welcome/new?project=big-station-421712