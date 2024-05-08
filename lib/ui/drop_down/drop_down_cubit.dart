import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_city_traveller/ui/drop_down/drop_down_state.dart';

class DropDownCubit extends Cubit<DropDownState>{
  DropDownCubit(super.initialState);

  changeArrow({required bool arrowChange}){
    emit(state.copyWith(isArrowClicked: arrowChange));
  }


}
