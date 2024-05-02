import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_city_traveller/ui/search/search_state.dart';

class SearchCubit extends Cubit<SearchState>{
  SearchCubit(super.initialState);

  void setSourceAddress(){
      state.sourceAddressController.value = TextEditingValue(text: state.address);
      emit(state.copyWith(sourceAddressController: state.sourceAddressController));
  }

}