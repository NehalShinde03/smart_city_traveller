import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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
import 'package:smart_city_traveller/ui/auth/sign_in/sign_in_cubit.dart';
import 'package:smart_city_traveller/ui/auth/sign_in/sign_in_state.dart';
import 'package:smart_city_traveller/ui/auth/sign_up/sign_up_ui.dart';
import 'package:lottie/lottie.dart';

class SignInUi extends StatefulWidget {
  const SignInUi({super.key});

  static const String routeName = '/sign_in_ui';
  static Widget builder(BuildContext context) => BlocProvider(
    create: (context) => SignInCubit(SignInState(
        emailController: TextEditingController(text: 'n@gmail.com'),
        passWordController: TextEditingController(text: '123'),
        firebaseAuth: FirebaseAuth.instance,
        globalKey: GlobalKey<FormState>()
      ),
    ),
    child: const SignInUi(),
  );

  @override
  State<SignInUi> createState() => _SignInUiState();
}

class _SignInUiState extends State<SignInUi> {

  SignInCubit get signInCubit => context.read<SignInCubit>();

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
                  text: "Sign in",
                  textColor: CommonColor.white,
                  fontSize: Spacing.xxLarge,
                  fontWeight: FontWeight.bold,
                ),
                CommonText(
                  text: "Welcome Back",
                  textColor: CommonColor.white,
                  fontSize: Spacing.large - Spacing.xSmall,
                  fontWeight: FontWeight.w400,
                ),
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
                  top: Spacing.xxxLarge*4,
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
                  child: BlocBuilder<SignInCubit, SignInState>(
                  builder: (context, state) {
                    return Form(
                    key: state.globalKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        CommonTextField(
                          controller: state.emailController,
                          borderColor: CommonColor.grey,
                          cursorColor: CommonColor.black,
                          hintText: "Email",
                          validator: validateEmail
                        ),

                        const Gap(Spacing.xLarge),
                        CommonTextField(
                          controller: state.passWordController,
                          borderColor: CommonColor.grey,
                          cursorColor: CommonColor.black,
                          hintText: "Password",
                          obscureText: !(state.password),
                          suffixIcon: GestureDetector(
                            onTap: (){
                              signInCubit.password(password: !state.password);
                            },
                            child: state.password
                                ? Icon(Icons.visibility_off, color: CommonColor.black.withOpacity(0.4),)
                                : Icon(Icons.visibility, color: CommonColor.black.withOpacity(0.4),)
                          ),

                          // suffixIcon: state.password
                          //     ? Icon(Icons.visibility_off, color: CommonColor.black.withOpacity(0.4),)
                          //     : Icon(Icons.visibility, color: CommonColor.black.withOpacity(0.4),),
                          // suffixIconOnTap: () => ,
                          validator: (val){
                            if(val!.isEmpty){
                              return "field is mandatory";
                            }
                            return null;
                          },
                        ),

                        const Gap(Spacing.xxLarge),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height/17,
                          child: CommonElevatedButton(
                              text: "Continue",
                              borderRadius: Spacing.medium,
                              buttonColor: CommonColor.black.withOpacity(0.8),
                              onPressed: (){
                                if(state.emailController.text.isNotEmpty && state.passWordController.text.isNotEmpty){
                                  signInCubit.credentialMatchLoginTime(context: context);
                                }
                              }
                          ),
                        ),

                        const Gap(Spacing.large),
                        RichText(
                            text: TextSpan(
                                children: [
                                  const TextSpan(
                                      text: "Don't have an account?",
                                      style: TextStyle(
                                          color: CommonColor.black
                                      )
                                  ),
                                  TextSpan(
                                      text: "\t\tSign Up",
                                      recognizer: TapGestureRecognizer()..onTap = () => Navigator.pushNamed(context, SignUpUi.routeName),
                                      style: const TextStyle(
                                          color: CommonColor.blue
                                      )
                                  ),
                                ]
                            )
                        ),

                        const Gap(Spacing.xxLarge),
                        const CommonText(
                          text: "⎻⎻⎻⎻⎻⎻⎻⎻⎻⎻⎻⎻⎻⎻⎻⎻⎻⎻⎻⎻⎻⎻⎻⎻⎻⎻  or continue with  ⎻⎻⎻⎻⎻⎻⎻⎻⎻⎻⎻⎻⎻⎻⎻⎻⎻⎻⎻⎻⎻⎻⎻⎻⎻⎻",
                          textColor: CommonColor.grey,
                          fontSize: Spacing.medium,
                        ),

                        const Gap(Spacing.xLarge),
                        GestureDetector(
                          onTap: () => signInCubit.singIn(context: context),
                          child: CircleAvatar(
                            backgroundColor: CommonColor.white,
                            child: Image.asset(CommonPng.google),
                          ),
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

          Padding(
            padding: const EdgeInsetsDirectional.only(
              top: Spacing.xxLarge*2,
              start: Spacing.xxxLarge*4.3,
            ),
            child: Image.asset(
              CommonPng.signIn,
              scale: Spacing.xSmall-2.5,
            ),
          ),

          BlocBuilder<SignInCubit, SignInState>(
              builder: (context, state) {
                print("state.login val==== ${state.isLogin}");
                if(state.isLogin){
                  return Container(
                    color: CommonColor.black.withOpacity(0.6),
                    child: Center(
                      child: Lottie.asset(
                          CommonAnimation.loader,
                          width: MediaQuery.of(context).size.width/3,
                          height: MediaQuery.of(context).size.height/3,
                          fit: BoxFit.fill,
                          // frameRate: FrameRate.composition,
                      ),
                    ),
                  );
                }
                else{
                  // signInCubit.loadValue(value: 2);
                  return const SizedBox();
                }
              }
            )
        ],
      ),
    );
  }
}
