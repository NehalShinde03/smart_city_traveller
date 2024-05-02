import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_city_traveller/ui/splash/splash_state.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashCubit extends Cubit<SplashState>{
  SplashCubit(super.initialState);

  void locationPermissions() async{
      PermissionStatus permissionStatus = await Permission.location.status;
      if(!permissionStatus.isGranted){
        permissionStatus = await Permission.location.request();
      }else{
        print("granted");
      }
  }

}