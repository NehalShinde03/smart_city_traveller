import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_city_traveller/ui/auth/sign_in/sign_in_ui.dart';
import 'package:smart_city_traveller/ui/profile/profile_cubit.dart';
import 'package:smart_city_traveller/ui/profile/profile_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileUi extends StatefulWidget {
  const ProfileUi({super.key});

  static const String routeName = '/profile_ui';
  static Widget builder(BuildContext context) => BlocProvider(
    create: (context) => ProfileCubit(ProfileState()),
    child: const ProfileUi(),
  );

  @override
  State<ProfileUi> createState() => _ProfileUiState();
}

class _ProfileUiState extends State<ProfileUi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IconButton(
          onPressed: () async{
            SharedPreferences preferences = await SharedPreferences.getInstance();
            preferences.clear();
            Navigator.popAndPushNamed(context, SignInUi.routeName);
          },
          icon: const Icon(Icons.exit_to_app),
        ),
      ),
    );
  }
}
