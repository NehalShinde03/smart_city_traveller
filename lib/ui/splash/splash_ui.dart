import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_city_traveller/ui/auth/sign_in/sign_in_ui.dart';
import 'package:smart_city_traveller/ui/bottom_nav_bar/bottom_nav_bar_view.dart';
import 'package:smart_city_traveller/ui/splash/splash_cubit.dart';
import 'package:smart_city_traveller/ui/splash/splash_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashUi extends StatefulWidget {
  const SplashUi({super.key});

  static const String routeName = '/splash_ui';
  static Widget builder(BuildContext context) => BlocProvider(
    create: (context) => SplashCubit(SplashState()),
    child: const SplashUi(),
  );

  @override
  State<SplashUi> createState() => _SplashUiState();
}

class _SplashUiState extends State<SplashUi> {


  @override
  void initState() {
    super.initState();
    context.read<SplashCubit>().locationPermissions();
    navigateAfterDelay();
  }

  void navigateAfterDelay(){
    Future.delayed(const Duration(seconds: 3), () async {
      final SharedPreferences preferences = await SharedPreferences.getInstance();
      ((preferences.getStringList("userInfo") ?? []).isEmpty)
          // ? Navigator.pushNamedAndRemoveUntil(context, BottomNavBarView.routeName, (route) => false)
          ? Navigator.pushNamedAndRemoveUntil(context, SignInUi.routeName, (route) => false)
          : Navigator.pushNamedAndRemoveUntil(context, BottomNavBarView.routeName, (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('here put image'),
      ),
    );
  }
}
