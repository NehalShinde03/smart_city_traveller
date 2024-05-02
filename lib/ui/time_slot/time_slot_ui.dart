import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_city_traveller/ui/time_slot/time_slot_cubit.dart';
import 'package:smart_city_traveller/ui/time_slot/time_slot_state.dart';

class TimeSlotUi extends StatefulWidget {
  const TimeSlotUi({super.key});

  static const String routeName = '/time_slot_ui.dart';
  static Widget builder(BuildContext context) => BlocProvider(
    create: (context) => TimeSlotCubit(TimeSlotState()),
    child: const TimeSlotUi(),
  );

  @override
  State<TimeSlotUi> createState() => _TimeSlotUiState();
}

class _TimeSlotUiState extends State<TimeSlotUi> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
