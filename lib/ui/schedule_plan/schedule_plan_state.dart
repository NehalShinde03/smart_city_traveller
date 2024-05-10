import 'package:equatable/equatable.dart';

class SchedulePlanState extends Equatable {
  final String startTime;
  final String endTime;
  final int index;
  final List<bool> checkBoxSelection;

  const SchedulePlanState({
    this.startTime = "",
    this.endTime = "",
    this.index = 0,
    this.checkBoxSelection = const [],
  });

  @override
  List<Object?> get props => [
        startTime,
        endTime,
        index,
        checkBoxSelection,
      ];

  SchedulePlanState copyWith({
    String? startTime,
    String? endTime,
    int? index,
    List<bool>? checkBoxSelection
  }) {
    return SchedulePlanState(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      index: index ?? this.index,
      checkBoxSelection: checkBoxSelection ?? this.checkBoxSelection
    );
  }
}
