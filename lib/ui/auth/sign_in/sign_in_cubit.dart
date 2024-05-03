import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_city_traveller/common/common_colors.dart';
import 'package:smart_city_traveller/common/widget/common_text.dart';
import 'package:smart_city_traveller/services/cloud_firestore_services.dart';
import 'package:smart_city_traveller/ui/auth/sign_in/sign_in_state.dart';
import 'package:smart_city_traveller/ui/home/home_ui.dart';
import 'package:smart_city_traveller/ui/on_bording_screen/on_boarding_ui.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class SignInCubit extends Cubit<SignInState>{
  SignInCubit(super.initialState);

  /// password visible - not visible
  void password({required bool password}){
    emit(state.copyWith(password: password));
  }

  /// match login data with  register user
  void credentialMatchLoginTime({context}) async{
    emit(state.copyWith(isLogin: true));
    if(state.emailController.text.isNotEmpty && state.passWordController.text.isNotEmpty){
      String userName = await CloudFireStoreServices.instance.compareCredential(
        email: state.emailController.text.trim(), password: state.passWordController.text.trim(),
      );
      print("name ===> $userName");
      emit(state.copyWith(userName: userName));
    }

    // emit(state.copyWith(userName: 'nehal')); // add this line extra
    if(state.globalKey.currentState!.validate() && state.userName!=""){
      storeUserNameNEmail(email: state.emailController.text);
      emit(state.copyWith(userName: state.userName, isLogin: false));
      Navigator.pushNamedAndRemoveUntil(context, OnBoardingUi.routeName, (route) => false);
    }
    else{
      if((state.emailController.text.isNotEmpty
          && state.passWordController.text.isNotEmpty)
          && state.userName==""){
        emit(state.copyWith(userName: state.userName, isLogin: false));
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: CommonColor.black.withOpacity(0.8),
            behavior: SnackBarBehavior.floating,
            elevation: 10,
            action: SnackBarAction(
              label: 'Dismiss',
              textColor: CommonColor.red,
              onPressed: (){},
            ),
            content: const CommonText(
              text: "Credential Wrong",
              textAlign: TextAlign.start,
              textColor: CommonColor.white,
            )
        ));
      }
      print("enter else");
    }
  }

  /// if credential match then it store username and email into local
  void storeUserNameNEmail({required String email}) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setStringList('userInfo', [email, state.userName]);
    print("sp data ===> ${preferences.getStringList('userInfo')?[0]}");
  }


  /// sign in using google
  Future<void> singIn({context}) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try{
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      if(googleSignInAccount!=null){
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
            idToken: googleSignInAuthentication.idToken,
            accessToken: googleSignInAuthentication.accessToken
        );
        state.firebaseAuth?.signInWithCredential(authCredential);

        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setStringList('userInfo', [state.firebaseAuth?.currentUser?.email ?? "", state.firebaseAuth?.currentUser?.displayName ?? ""]);
        Navigator.pushNamedAndRemoveUntil(context, HomeUi.routeName, (route) => false);
      }
    }catch(e){
      print("e ===> $e");
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: CommonText(text: "Network Issuesss..!!!",),
      ),
      );
    }
  }

  /// enable loader on login time
  void waitForLogin({required bool login}){
    emit(state.copyWith(isLogin: login));
  }

}
