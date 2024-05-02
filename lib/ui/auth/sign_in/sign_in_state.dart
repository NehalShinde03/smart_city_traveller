import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class SignInState extends Equatable {
  final bool password;
  final TextEditingController emailController;
  final TextEditingController passWordController;
  final String userName;
  final FirebaseAuth? firebaseAuth;
  final bool isLogin;
  final GlobalKey<FormState> globalKey;


  const SignInState(
      {this.password = false,
      required this.emailController,
      required this.passWordController,
      this.userName = "",
      this.firebaseAuth,
      this.isLogin = false,
      required this.globalKey
      });

  @override
  List<Object?> get props => [
        password,
        emailController,
        passWordController,
        userName,
        firebaseAuth,
        isLogin,
        globalKey
      ];

  SignInState copyWith({
    bool? password,
    TextEditingController? emailController,
    TextEditingController? passWordController,
    String? userName,
    FirebaseAuth? firebaseAuth,
    bool? isLogin,
    GlobalKey<FormState>? globalKey
  }) {
    return SignInState(
      password: password ?? this.password,
      emailController: emailController ?? this.emailController,
      passWordController: passWordController ?? this.passWordController,
      userName: userName ?? this.userName,
      firebaseAuth: firebaseAuth ?? this.firebaseAuth,
      isLogin: isLogin ?? this.isLogin,
      globalKey: globalKey ?? this.globalKey,
    );
  }
}
