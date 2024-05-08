import 'package:equatable/equatable.dart';

class DropDownState extends Equatable {

  final bool isArrowClicked;

  const DropDownState({
    this.isArrowClicked = false,
  });

  @override
  List<Object?> get props => [isArrowClicked];


  DropDownState copyWith({
    bool? isArrowClicked,
  }) {
    return DropDownState(
      isArrowClicked: isArrowClicked ?? this.isArrowClicked,
    );
  }

}
