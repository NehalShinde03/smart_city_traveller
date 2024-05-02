import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_city_traveller/common/widget/bottom_navigation.dart';
import 'package:smart_city_traveller/common/widget/enum.dart';
import 'package:smart_city_traveller/ui/bottom_nav_bar/bottom_nav_bar_cubit.dart';
import 'package:smart_city_traveller/ui/bottom_nav_bar/bottom_nav_bar_state.dart';
import 'package:smart_city_traveller/ui/go/go_ui.dart';
import 'package:smart_city_traveller/ui/home/home_ui.dart';
import 'package:smart_city_traveller/ui/profile/profile_ui.dart';
import 'package:smart_city_traveller/ui/time_slot/time_slot_ui.dart';
class BottomNavBarViewArgument {
  // final String? userCode;
  final BottomNavigationOption bottomNavigationOption;

  const BottomNavBarViewArgument({
    // required this.userCode,
    required this.bottomNavigationOption,
  });
}

class BottomNavBarView extends StatefulWidget {
  const BottomNavBarView({super.key});

  static const String routeName = '/main_view';

  static Widget builder(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    return BlocProvider(
      create: (context) => BottomNavBarCubit(BottomNavBarState(
        navigationOption: args is BottomNavBarViewArgument
            ? args.bottomNavigationOption
            : BottomNavigationOption.home,
      )),
      child: const BottomNavBarView(),
    );
  }

  @override
  State<BottomNavBarView> createState() => _BottomNavBarViewState();
}

class _BottomNavBarViewState extends State<BottomNavBarView> {
  BottomNavBarCubit get cubit => BlocProvider.of<BottomNavBarCubit>(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
        BlocSelector<BottomNavBarCubit, BottomNavBarState, BottomNavigationOption>(
        selector: (state) => state.navigationOption,
        builder: (context, selectTab) {
          return BottomNavBar(
            selectedTab: selectTab,
            onTabChanged: cubit.onTabChange,
          );
        },
      ),
      body: BlocBuilder<BottomNavBarCubit, BottomNavBarState>(
        builder: (context, state) {
          final child = switch (state.navigationOption) {
            BottomNavigationOption.home => HomeUi.builder(context),
            BottomNavigationOption.go => GoUi.builder(context),
            BottomNavigationOption.timeSlot => TimeSlotUi.builder(context),
            BottomNavigationOption.profile => ProfileUi.builder(context),
           _ => HomeUi.builder(context),
          };
          return PopScope(
            canPop: state.navigationOption == BottomNavigationOption.home,
            child: child,
          );
        },
      ),
    );
  }
}
