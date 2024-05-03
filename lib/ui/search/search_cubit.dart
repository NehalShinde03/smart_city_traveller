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

}



///place api :: AIzaSyCXb3JSLUgurnIUOgtB599ncur-Mvja5a4
///https://console.cloud.google.com/welcome/new?project=big-station-421712