import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_city_traveller/ui/view_plan/view_plan_cubit.dart';
import 'package:smart_city_traveller/ui/view_plan/view_plan_state.dart';

class ViewPlanUi extends StatefulWidget {
  const ViewPlanUi({super.key});

  static const String routeName = '/view_plan_ui.dart';
  static Widget builder(BuildContext context) => BlocProvider(
    create: (context) => ViewPlanCubit(ViewPlanState()),
    child: const ViewPlanUi(),
  );

  @override
  State<ViewPlanUi> createState() => _ViewPlanUiState();
}

class _ViewPlanUiState extends State<ViewPlanUi> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
