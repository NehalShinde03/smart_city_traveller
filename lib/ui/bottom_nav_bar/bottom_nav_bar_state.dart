import 'package:equatable/equatable.dart';
import 'package:smart_city_traveller/common/widget/enum.dart';

class BottomNavBarState extends Equatable {
  ///for drop down
  final BottomNavigationOption navigationOption;

  const BottomNavBarState({
    required this.navigationOption,
  });

  @override
  List<Object?> get props => [navigationOption];

  BottomNavBarState copyWith({
    BottomNavigationOption? navigationOption,
  }) {
    return BottomNavBarState(
      navigationOption: navigationOption ?? this.navigationOption,
    );
  }
}
