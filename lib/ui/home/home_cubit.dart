import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_city_traveller/ui/home/home_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeCubit extends Cubit<HomeState>{
  HomeCubit(super.initialState){}

  void initSharedPreferences() async{
    print("enter");
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    emit(state.copyWith(userInfo: preferences.getStringList('userInfo')));
    print("cubit exe");
  }

  void isDirectionIconClick({required bool isDirectionIconClick}){
    emit(state.copyWith(isDirectionIconClick: isDirectionIconClick));
  }

}