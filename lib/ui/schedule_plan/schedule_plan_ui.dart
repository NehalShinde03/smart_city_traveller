import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_city_traveller/common/common_colors.dart';
import 'package:smart_city_traveller/common/common_images.dart';
import 'package:smart_city_traveller/common/common_spacing.dart';
import 'package:smart_city_traveller/common/widget/common_elevated_button.dart';
import 'package:smart_city_traveller/common/widget/common_text.dart';
import 'package:smart_city_traveller/common/widget/enum.dart';
import 'package:smart_city_traveller/ui/bottom_nav_bar/bottom_nav_bar_cubit.dart';
import 'package:smart_city_traveller/ui/bottom_nav_bar/bottom_nav_bar_state.dart';
import 'package:smart_city_traveller/ui/bottom_nav_bar/bottom_nav_bar_view.dart';
import 'package:smart_city_traveller/ui/schedule_plan/schedule_plan_cubit.dart';
import 'package:smart_city_traveller/ui/schedule_plan/schedule_plan_state.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SchedulePlanUi extends StatefulWidget {
  const SchedulePlanUi({super.key});

  static const String routeName = '/schedule_plan_ui.dart';
  static Widget builder(BuildContext context) =>
      BlocProvider(
        create: (context) => SchedulePlanCubit(
          SchedulePlanState(
              checkBoxSelection: List.generate(8, (index) => false)
          ),
        ),
        child: const SchedulePlanUi(),
      );

  @override
  State<SchedulePlanUi> createState() => _SchedulePlanUiState();
}

class _SchedulePlanUiState extends State<SchedulePlanUi> {

  SchedulePlanCubit get schedulePlanCubit => context.read<SchedulePlanCubit>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsetsDirectional.only(
              start: Spacing.small,
            end: Spacing.small,
            bottom: Spacing.medium
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                ///Schedule your Trip...
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    top: Spacing.xxLarge,
                  ),
                  child: CommonText(
                    text: "Schedule your Trip...",
                    fontWeight: FontWeight.bold,
                    fontSize: Spacing.large,
                    textColor: CommonColor.black.withOpacity(0.7),
                  ),
                ),

                /// lottie
                Align(
                  alignment: Alignment.center,
                  child: Lottie.asset(
                      CommonAnimation.plans,
                      width: Spacing.xxxLarge * 4,
                      fit: BoxFit.fill,
                  ),
                ),

                ///Enter the time below and let us plan!
                const Gap(Spacing.xxLarge),
                CommonText(
                  text: "Enter the time below and let us plan!",
                  fontWeight: FontWeight.bold,
                  textColor: CommonColor.black.withOpacity(0.7),
                  fontSize: Spacing.medium + Spacing.xSmall ,
                ),

                /// start time
                const Gap(Spacing.xLarge),
                Card(
                  elevation: 20,
                  child: BlocSelector<SchedulePlanCubit, SchedulePlanState, String>(
                  selector: (state) => state.startTime,
                  builder: (context, startTime) {
                    return ListTile(
                    leading: const Icon(
                        Icons.schedule,
                        color: CommonColor.teal,
                    ),
                    trailing: TextButton(
                        onPressed: () async{
                          schedulePlanCubit.selectStartTime(context: context);
                          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                          sharedPreferences.setString('startTime',startTime);
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: CommonColor.white,
                          padding: PaddingValue.zero
                        ),
                        child: const CommonText(
                          text: "Change",
                          textColor: CommonColor.teal,
                          fontWeight: FontWeight.bold,
                        ),
                    ),
                    title: CommonText(
                      text: startTime.isEmpty ? "Select Start Time" : startTime,
                      textAlign: TextAlign.start,
                      textColor: CommonColor.grey,
                      fontWeight: FontWeight.bold,
                    ),
                    tileColor: CommonColor.white,
                  );
                  },
                 ),
                ),

                /// end time
                const Gap(Spacing.medium),
                Card(
                  elevation: 20,
                  color: CommonColor.white,
                  child: BlocSelector<SchedulePlanCubit, SchedulePlanState, String>(
                  selector: (state) => state.endTime,
                  builder: (context, endTime) {
                    return ListTile(
                    leading: const Icon(
                      Icons.schedule,
                      color: CommonColor.teal,
                    ),
                    trailing: TextButton(
                      onPressed: () async {
                        schedulePlanCubit.selectEndTime(context: context);
                        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                        sharedPreferences.setString('endTime',endTime);
                      },
                      style: TextButton.styleFrom(
                          foregroundColor: CommonColor.white,
                          padding: PaddingValue.zero,
                      ),
                      child: const CommonText(
                        text: "Change",
                        textColor: CommonColor.teal,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    title: CommonText(
                      text: endTime.isEmpty ? "Select End Time" : endTime,
                      textAlign: TextAlign.start,
                      textColor: CommonColor.grey,
                      fontWeight: FontWeight.bold,
                    ),
                    tileColor: CommonColor.white,
                  );
                  },
                ),
                ),

                /// select category
                const Gap(Spacing.xxLarge),
                CommonText(
                  text: "Select Category:",
                  fontWeight: FontWeight.bold,
                  textColor: CommonColor.black.withOpacity(0.7),
                  fontSize: Spacing.medium + Spacing.xSmall ,
                ),



                /// list of check box
                BlocSelector<SchedulePlanCubit, SchedulePlanState, List<bool>>(
                selector: (state) => state.checkBoxSelection,
                builder: (context, checkBoxSelection) {
                  print("check box valuess ------> $checkBoxSelection");
                  return SizedBox(
                  height: MediaQuery.of(context).size.height/3.7,
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: Spacing.xxxLarge,
                    ),
                    padding: PaddingValue.zero,
                    itemCount: PlaceCategory.values.length,
                    itemBuilder: (context, index){
                      return CheckboxListTile(
                        value: checkBoxSelection[index],
                        hoverColor: Colors.white,
                        title: CommonText(text: PlaceCategory.values[index].name, textAlign: TextAlign.start,),
                        activeColor: CommonColor.teal,
                        controlAffinity: ListTileControlAffinity.leading,
                        onChanged: (checked){
                          context.read<SchedulePlanCubit>().changeCategoryStatus(
                            checkBoxStatus: (checked ?? false),
                            index: index,
                          );
                        },
                     );
                    },
                  ),
                );
                },
              ),

                /// let's go button
                Align(
                  alignment: Alignment.center,
                  child: CommonElevatedButton(
                    text: "Let's Go",
                    buttonColor: CommonColor.teal,
                    onPressed: () async {
                      SchedulePlanState state = schedulePlanCubit.state;
                      print("bun state checkbox ------ ${state.checkBoxSelection}");
                      if(state.startTime.isNotEmpty && state.endTime.isNotEmpty){
                        if(state.checkBoxSelection.contains(true)){
                          // Navigator.pushReplacementNamed(context, BottomNavBarView.routeName, arguments: const BottomNavBarViewArgument(bottomNavigationOption: BottomNavigationOption.home));
                          // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                          // sharedPreferences.setString('schedulePlan', );
                          schedulePlanCubit.differenceBetweenTwoTimes(startingTime: state.startTime, endingTime: state.endTime);
                          Navigator.popAndPushNamed(context, BottomNavBarView.routeName, arguments: const BottomNavBarViewArgument(bottomNavigationOption: BottomNavigationOption.home));
                        }
                        else{
                          Fluttertoast.showToast(
                            msg: "📍 Please Select Category",
                            gravity: ToastGravity.TOP,
                            backgroundColor: CommonColor.black.withOpacity(0.5),
                            toastLength: Toast.LENGTH_LONG,
                          );
                        }
                      }
                      else{
                            Fluttertoast.showToast(
                                msg: "⌚ Please Select Time.",
                                gravity: ToastGravity.TOP,
                                backgroundColor: CommonColor.black.withOpacity(0.5),
                                toastLength: Toast.LENGTH_LONG,
                            );
                      }
                    },
                    borderRadius: Spacing.medium,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
