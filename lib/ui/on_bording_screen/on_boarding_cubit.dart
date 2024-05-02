import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_city_traveller/ui/on_bording_screen/on_boarding_state.dart';

class OnBoardingCubit extends  Cubit<OnBoardingState>{
  OnBoardingCubit(super.initialState){
  }

  void changeOpacity({required double opacityValue}){
    emit(state.copyWith(opacityValue: opacityValue));
  }

  void changeAlignment({required Alignment titleAlignment, required Alignment descriptionAlignment}){
    emit(state.copyWith(
        titleAlignment: titleAlignment,
        descriptionAlignment: descriptionAlignment,
    ));
  }

  void updatePage({required int index}){
    emit(state.copyWith(index: index));
  }

}