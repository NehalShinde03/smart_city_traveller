import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_city_traveller/ui/auth/sign_up/sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState>{
  SignUpCubit(super.initialState);

  /// password visible and invisible
  void password({required bool password}){
    emit(state.copyWith(password: password));
  }

  /// confirm password visible and invisible
  void confirmPassword({required bool confirmPassword}){
    emit(state.copyWith(confirmPassword: confirmPassword));
  }

  /// check password and cofirm password is match
  void checkPasswordNConfirmPasswordMatch({required String confirmPassword}){
    if(state.passWordController.text == confirmPassword){
      emit(state.copyWith(matchPasswordMessage: "password match"));
    }else{
      emit(state.copyWith(matchPasswordMessage: "password not match"));
    }
  }

}