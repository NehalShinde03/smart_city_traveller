import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class SignUpState extends Equatable {

  final bool password;
  final bool confirmPassword;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passWordController;
  final TextEditingController confirmPassWordController;
  final String matchPasswordMessage;
  final GlobalKey<FormState> globalKey;


  const SignUpState({
    this.password = false,
    this.confirmPassword = false,
    required this.nameController,
    required this.emailController,
    required this.passWordController,
    required this.confirmPassWordController,
    this.matchPasswordMessage = "",
    required this.globalKey
  });


  @override
  List<Object?> get props => [
        password,
        confirmPassword,
        nameController,
        emailController,
        passWordController,
        confirmPassWordController,
        matchPasswordMessage,
        globalKey
      ];


  SignUpState copyWith({
    bool? password,
    bool? confirmPassword,
    TextEditingController? nameController,
    TextEditingController? emailController,
    TextEditingController? passWordController,
    TextEditingController? confirmPassWordController,
    bool? isPasswordMatch,
    String? matchPasswordMessage,
    GlobalKey<FormState>? globalKey
  }) {
    return SignUpState(
        globalKey: globalKey ?? this.globalKey,
        password: password ?? this.password,
        confirmPassword: confirmPassword ?? this.confirmPassword,
        nameController: nameController ?? this.nameController,
        emailController: emailController ?? this.emailController,
        passWordController: passWordController ?? this.passWordController,
        confirmPassWordController: confirmPassWordController ?? this.confirmPassWordController,
        matchPasswordMessage: matchPasswordMessage ?? this.matchPasswordMessage
    );
  }
}
