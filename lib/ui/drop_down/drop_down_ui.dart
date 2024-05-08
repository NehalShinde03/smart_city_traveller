import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_city_traveller/common/common_spacing.dart';
import 'package:smart_city_traveller/common/widget/common_text.dart';
import 'package:smart_city_traveller/ui/drop_down/drop_down_cubit.dart';
import 'package:smart_city_traveller/ui/drop_down/drop_down_state.dart';

class DropDownUi extends StatefulWidget {
  const DropDownUi({super.key});

  static const String routeName = "/drop_down_ui";

  static Widget builder(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return DropDownCubit(const DropDownState());
      },
      child: const DropDownUi(),
    );
  }


  @override
  State<DropDownUi> createState() => _DropDownUiState();
}

class _DropDownUiState extends State<DropDownUi> {

  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: BlocBuilder<DropDownCubit, DropDownState>(
          builder: (context, state) {
            return Stack(
            children: [
              // Image.asset(CommonJpg.profilePicture, fit: BoxFit.cover, ),
              BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0,),
                  child: Container()
              ),

              Positioned(
                top: state.isArrowClicked ? Spacing.xxxLarge*3.9 : Spacing.xxLarge + 1,
                left: 150,
                child: GestureDetector(
                  onTap: () {
                    context.read<DropDownCubit>().changeArrow(
                        arrowChange: !state.isArrowClicked);
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.black,
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(top: Spacing.xMedium,),
                      child: Icon(
                        state.isArrowClicked
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: Colors.white, size: Spacing.xxxLarge * 1,),
                    ),
                  ),
                ),
              ),

              Container(
                width: MediaQuery.of(context).size.width,
                height: state.isArrowClicked
                  ? MediaQuery.of(context).size.height / 4
                  : MediaQuery.of(context).size.height / 13,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20)
                ),
                padding: const EdgeInsetsDirectional.symmetric(horizontal: Spacing.medium),
                margin: const EdgeInsetsDirectional.symmetric(horizontal: Spacing.small),
                child: (state.isArrowClicked)
                        ? Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CommonText(text: 'Select Location', textColor: Colors.white, fontWeight: FontWeight.bold,),
                            TextField(
                              style: const TextStyle(
                                color: Colors.white
                              ),
                              decoration: InputDecoration(
                                hintText: 'Country',
                                hintStyle: const TextStyle(
                                  color: Colors.grey,
                                ),
                                contentPadding: const EdgeInsetsDirectional.only(
                                    start: Spacing.large,
                                    bottom: Spacing.large,
                                    end: Spacing.medium
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(Spacing.medium),
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(Spacing.medium),
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                            ),
                            TextField(onTap: () {
                              print("object");
                            },
                              decoration: InputDecoration(
                                hintText: 'City',
                                hintStyle: const TextStyle(
                                  color: Colors.grey,
                                ),
                                contentPadding: const EdgeInsetsDirectional.only(
                                    start: Spacing.large,
                                    bottom: Spacing.large,
                                    end: Spacing.medium
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(Spacing.medium),
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(Spacing.medium),
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        )
                        : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                              CommonText(text: 'select location', textColor: Colors.white,),
                              Icon(Icons.location_on, color: Colors.white,)
                            ],
                          )
              ),



            ],
          );
          },
        )
      ),
    );
  }
}

