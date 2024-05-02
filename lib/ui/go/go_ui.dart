import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_city_traveller/ui/go/go_cubit.dart';
import 'package:smart_city_traveller/ui/go/go_state.dart';

class GoUi extends StatefulWidget {
  const GoUi({super.key});

  static const String routeName = '/go_ui.dart';
  static Widget builder(BuildContext context) => BlocProvider(
    create: (context) => GoCubit(GoState()),
    child: const GoUi(),
  );

  @override
  State<GoUi> createState() => _GoUiState();
}

class _GoUiState extends State<GoUi> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
