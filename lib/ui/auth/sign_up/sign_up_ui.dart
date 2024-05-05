import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:smart_city_traveller/common/common_colors.dart';
import 'package:smart_city_traveller/common/common_images.dart';
import 'package:smart_city_traveller/common/common_spacing.dart';
import 'package:smart_city_traveller/common/validation.dart';
import 'package:smart_city_traveller/common/widget/common_elevated_button.dart';
import 'package:smart_city_traveller/common/widget/common_text.dart';
import 'package:smart_city_traveller/common/widget/common_textfield.dart';
import 'package:smart_city_traveller/model/sign_up_model.dart';
import 'package:smart_city_traveller/services/cloud_firestore_services.dart';
import 'package:smart_city_traveller/ui/auth/sign_up/sign_up_cubit.dart';
import 'package:smart_city_traveller/ui/auth/sign_up/sign_up_state.dart';

class SignUpUi extends StatefulWidget {
  const SignUpUi({super.key});

  static const String routeName = '/sign_up_ui';
  static Widget builder(BuildContext context) => BlocProvider(
    create: (context) => SignUpCubit(SignUpState(
      globalKey: GlobalKey<FormState>(),
      nameController: TextEditingController(),
      emailController: TextEditingController(),
      passWordController: TextEditingController(),
      confirmPassWordController: TextEditingController()
    )),
    child: const SignUpUi(),
  );

  @override
  State<SignUpUi> createState() => _SignUpUiState();
}

class _SignUpUiState extends State<SignUpUi> {

  SignUpCubit get signUpCubit => context.read<SignUpCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [

          const Positioned(
            top: Spacing.xxxLarge,
            left: Spacing.xLarge,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                  text: "Sign up",
                  textColor: CommonColor.white,
                  fontSize: Spacing.xxLarge,
                  fontWeight: FontWeight.bold,
                ),
                CommonText(
                  text: "Create an account to get started",
                  textColor: CommonColor.white,
                  fontSize: Spacing.large - Spacing.xSmall,
                  fontWeight: FontWeight.w400,
                )
              ],
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/1.4,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadiusDirectional.only(
                  topStart: Radius.circular(Spacing.xxLarge),
                  topEnd: Radius.circular(Spacing.xxLarge),
                ),
              ),
              padding: const EdgeInsetsDirectional.only(
                  top: Spacing.xxxLarge*3,
                  start: Spacing.medium,
                  end: Spacing.medium
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding:  EdgeInsetsDirectional.only(
                      top: Spacing.small,
                      start: Spacing.medium,
                      end: Spacing.medium,
                      bottom: Spacing.medium + MediaQuery.of(context).viewInsets.bottom
                  ),
                  child: BlocBuilder<SignUpCubit, SignUpState>(
                  builder: (context, state) {
                    return Form(
                      key: state.globalKey,
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        CommonTextField(
                          controller: state.nameController,
                          borderColor: CommonColor.grey,
                          cursorColor: CommonColor.black,
                          hintText: "Name",
                          validator: (val){
                            if(val!.isEmpty){
                              return "field is mandatory";
                            }
                            return null;
                          },
                        ),

                        const Gap(Spacing.xLarge),
                        CommonTextField(
                          controller: state.emailController,
                          borderColor: CommonColor.grey,
                          cursorColor: CommonColor.black,
                          hintText: "Email",
                          validator: validateEmail,
                        ),

                        const Gap(Spacing.xLarge),
                        CommonTextField(
                          controller: state.passWordController,
                          borderColor: CommonColor.grey,
                          cursorColor: CommonColor.black,
                          hintText: "Password",
                          obscureText: !(state.password),
                          suffixIcon: GestureDetector(
                            onTap: () => signUpCubit.password(password: !state.password),
                            child: state.password
                                ? Icon(Icons.visibility_off, color: CommonColor.black.withOpacity(0.4),)
                                : Icon(Icons.visibility, color: CommonColor.black.withOpacity(0.4),)
                          ),
                          /*suffixIcon: state.password
                              ? Icon(Icons.visibility_off, color: CommonColor.black.withOpacity(0.4),)
                              : Icon(Icons.visibility, color: CommonColor.black.withOpacity(0.4),),
                          suffixIconOnTap: () => signUpCubit.password(password: !state.password),*/
                          validator: (val){
                            if(val!.isEmpty){
                              return "field is mandatory";
                            }
                            return null;
                          },
                        ),

                        const Gap(Spacing.xLarge),
                        CommonTextField(
                          controller: state.confirmPassWordController,
                          borderColor: CommonColor.grey,
                          cursorColor: CommonColor.black,
                          hintText: "Confirm Password",
                          obscureText: !(state.confirmPassword),
                          suffixIcon: GestureDetector(
                            onTap: () => signUpCubit.confirmPassword(confirmPassword: !state.confirmPassword),
                            child: state.confirmPassword
                                  ? Icon(Icons.visibility_off, color: CommonColor.black.withOpacity(0.4),)
                                  : Icon(Icons.visibility, color: CommonColor.black.withOpacity(0.4),),
                          ),
                          // suffixIcon: state.confirmPassword
                          //       ? Icon(Icons.visibility_off, color: CommonColor.black.withOpacity(0.4),)
                          //       : Icon(Icons.visibility, color: CommonColor.black.withOpacity(0.4),),
                          // suffixIconOnTap: () => signUpCubit.confirmPassword(confirmPassword: !state.confirmPassword),
                          onChanged: (val){
                            signUpCubit.checkPasswordNConfirmPasswordMatch(confirmPassword: val);
                          },
                          validator: (val){
                            if(val!.isEmpty){
                              return "field is mandatory";
                            }
                            return null;
                          }
                        ),

                        Padding(
                          padding: const EdgeInsetsDirectional.only(start: Spacing.xSmall, top: Spacing.xSmall),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: BlocBuilder<SignUpCubit, SignUpState>(
                            builder: (context, state) {
                              return CommonText(
                              text: state.matchPasswordMessage,
                              textAlign: TextAlign.center,
                              fontSize: Spacing.medium,
                              textColor: state.matchPasswordMessage == "password match"
                                          ? Colors.green
                                          : Colors.red,
                            );
                            },
                           ),
                          ),
                        ),

                        const Gap(Spacing.xxLarge),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height/17,
                          child: CommonElevatedButton(
                            text: "Continue",
                            borderRadius: Spacing.medium,
                            onPressed: (){
                              if(state.globalKey.currentState!.validate()){
                                 CloudFireStoreServices.instance.signUp(signUpModel: SignUpModel(
                                   userName: state.nameController.text.trim(),
                                   userEmail: state.emailController.text.trim(),
                                   userPassWord: state.passWordController.text.trim(),
                                   userConfirmPassWord: state.confirmPassWordController.text.trim()
                                 ));
                                 Navigator.pop(context);
                              }
                            },
                            buttonColor: CommonColor.black.withOpacity(0.8),
                          ),
                        ),

                        const Gap(Spacing.large),
                        RichText(
                            text: TextSpan(
                                children: [
                                  const TextSpan(
                                      text: "Already have an account?",
                                      style: TextStyle(
                                          color: CommonColor.black
                                      )
                                  ),
                                  TextSpan(
                                      text: "\t\tSign In",
                                      recognizer: TapGestureRecognizer()..onTap = () => Navigator.pop(context),
                                      style: const TextStyle(
                                          color: CommonColor.blue
                                      )
                                  ),
                                ]
                            )
                        ),

                      ],
                      ),
                    );
                  },
                ),
                ),
              ),
            ),
          ),

          Positioned(
            top: Spacing.xxLarge*2,
            left: Spacing.xxxLarge*4.7,
            child: Image.asset(
              CommonPng.signUp,
              scale: Spacing.xSmall-2.5,
            ),
          )

        ],
      ),
    );
  }
}
