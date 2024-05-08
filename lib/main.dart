import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smart_city_traveller/ui/auth/sign_in/sign_in_ui.dart';
import 'package:smart_city_traveller/ui/auth/sign_up/sign_up_ui.dart';
import 'package:smart_city_traveller/ui/bottom_nav_bar/bottom_nav_bar_view.dart';
import 'package:smart_city_traveller/ui/go/go_ui.dart';
import 'package:smart_city_traveller/ui/home/home_ui.dart';
import 'package:smart_city_traveller/ui/on_bording_screen/on_boarding_ui.dart';
import 'package:smart_city_traveller/ui/profile/profile_ui.dart';
import 'package:smart_city_traveller/ui/search/search_ui.dart';
import 'package:smart_city_traveller/ui/splash/splash_ui.dart';
import 'package:smart_city_traveller/ui/time_slot/time_slot_ui.dart';
import 'firebase_options.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: navigatorKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      routes: routes,
      initialRoute: SplashUi.routeName,
    );
  }

  Map<String, WidgetBuilder> get routes => {
    SplashUi.routeName:SplashUi.builder,
    SignInUi.routeName:SignInUi.builder,
    SignUpUi.routeName:SignUpUi.builder,
    HomeUi.routeName:HomeUi.builder,
    SearchUi.routeName:SearchUi.builder,
    OnBoardingUi.routeName:OnBoardingUi.builder,
    BottomNavBarView.routeName:BottomNavBarView.builder,
    GoUi.routeName:GoUi.builder,
    TimeSlotUi.routeName:TimeSlotUi.builder,
    ProfileUi.routeName:ProfileUi.builder,
    // DropDownUi.routeName:DropDownUi.builder
  };

}
