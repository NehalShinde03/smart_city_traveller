import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_city_traveller/ui/schedule_plan/schedule_plan_state.dart';

class SchedulePlanCubit extends Cubit<SchedulePlanState>{

  List<bool> checkBoxSelection = List.generate(8, (index) => false);

  SchedulePlanCubit(super.initialState);

  Future<void> selectStartTime({context}) async {
     final startTime = await showTimePicker(
         context: context,
         initialTime: TimeOfDay.now(),
         builder: (context, child){
           return MediaQuery(
               data: MediaQuery.of(context).copyWith(
                   boldText: true,
                   // alwaysUse24HourFormat: true
               ),
               child: child!,
           );
         }
     );

     if(startTime!=null){
       /// add second in time, the showTimePicker provide only hour and minute
       String second = DateTime.now().second.toString().padLeft(2,'0');
       List formatTime = startTime.format(context).split(' ');
       if(formatTime.length>1){
         emit(state.copyWith(startTime: "${formatTime.first}:$second ${formatTime.last}"));
       }
       print("start time =====> ${state.startTime}");
     }
  }

  Future<void> selectEndTime({context}) async {
    final endTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, child){
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              boldText: true,
              // alwaysUse24HourFormat: true,
            ),
            child: child!,
          );
        }
    );
    if(endTime!=null){
      String second = DateTime.now().second.toString().padLeft(2,'0');
      List formatTime = endTime.format(context).split(' ');

      if(formatTime.length>1){
        emit(state.copyWith(endTime: "${formatTime.first}:$second ${formatTime.last}"));
      }
      print("End Time =====> ${state.endTime}");
    }
  }

  void changeCategoryStatus({required bool checkBoxStatus, required int index}){
    checkBoxSelection[index] = checkBoxStatus;
    emit(state.copyWith(checkBoxSelection: List<bool>.from(checkBoxSelection)));
    print("state.categoryList =====> ${state.checkBoxSelection}");
  }


  Future<void> differenceBetweenTwoTimes({required String startingTime, required String endingTime}) async {
    // String startTime = startingTime.substring(0, startingTime.length-3);
    // String endTime = endingTime.substring(0, endingTime.length-3);

    DateTime convertStatDateTime = DateFormat('hh:mm:ss a').parse(startingTime);
    DateTime convertEndDateTime = DateFormat('hh:mm:ss a').parse(endingTime);

    print("start times =====> $convertStatDateTime");

    final Duration differenceBetweenTime = convertEndDateTime.difference(convertStatDateTime).abs();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('differenceBetweenTime', '${differenceBetweenTime.inHours%24} : ${differenceBetweenTime.inMinutes%60} : ${differenceBetweenTime.inSeconds%60}');
    sharedPreferences.setString('mapTopBarValue','2');

    print("differece time =====> ${differenceBetweenTime.inHours}h ${differenceBetweenTime.inMinutes%60}m ${differenceBetweenTime.inSeconds%60}s");

    print("formatted DateTime s ====> ${convertStatDateTime.toIso8601String()}");
    print("formatted DateTime e ====> ${convertEndDateTime.toIso8601String()}");

  }

}


/*  Future<void> selectStartTime({context}) async {
     final startTime = await showTimePicker(
         context: context,
         initialTime: TimeOfDay.now(),
         builder: (context, child){
           return MediaQuery(
               data: MediaQuery.of(context).copyWith(
                   boldText: true,
               ),
               child: child!,
           );
         }
     );

     if(startTime!=null){
       DateTime dateTime = DateTime.now();
       String second = dateTime.second.toString().padLeft(2,'0');
       List formatTime = startTime.format(context).split(' ');

       if(formatTime.length>1){
         // ${formatTime.last}
         String currentTime = "${formatTime.first}:$second";
         dateTime = DateFormat("HH:mm:ss").parse(currentTime);
         Timer.periodic(const Duration(seconds: 1), (timer) {
           if(timer.tick >= 0){
             Duration d = const Duration(seconds: 1);
             dateTime = dateTime.subtract(d);
             print("dateTime =====> $dateTime");
             emit(state.copyWith(startTime: dateTime.toString()));
           }
         });
       }

     }
  }*/