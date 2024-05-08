import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_city_traveller/common/common_colors.dart';
import 'package:smart_city_traveller/common/common_images.dart';
import 'package:smart_city_traveller/common/common_spacing.dart';
import 'package:smart_city_traveller/common/widget/common_text.dart';
import 'package:smart_city_traveller/common/widget/common_textfield.dart';
import 'package:smart_city_traveller/common/widget/enum.dart';
import 'package:smart_city_traveller/ui/bottom_nav_bar/bottom_nav_bar_cubit.dart';
import 'package:smart_city_traveller/ui/bottom_nav_bar/bottom_nav_bar_state.dart';
import 'package:smart_city_traveller/ui/bottom_nav_bar/bottom_nav_bar_view.dart';
import 'package:smart_city_traveller/ui/search/search_cubit.dart';
import 'package:smart_city_traveller/ui/search/search_state.dart';

class SearchUi extends StatefulWidget {
  const SearchUi({super.key});

  static const String routeName = "/search_ui";

  static Widget builder(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as String?;
    print("search adrees ====> ${args}");
    return BlocProvider(
      create: (context) {
        return SearchCubit(SearchState(
            sourceAddressController: TextEditingController(),
            destinationAddressController: TextEditingController(),
            address: args ?? ""
          // latLng: args
        ));
      },
      child: const SearchUi(),
    );
  }

  @override
  State<SearchUi> createState() => _SearchUiState();
}

class _SearchUiState extends State<SearchUi> {

  SearchCubit get searchCubit => context.read<SearchCubit>();
  BottomNavBarCubit get bottomNavBar => context.read<BottomNavBarCubit>();
  // FocusNode focusNode = FocusNode();
  // final _debouncer = Debouncer(millisecond: 300);

  @override
  void initState() {
    super.initState();
    searchCubit.setSourceAddress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsetsDirectional.only(
            start: Spacing.medium,
            end: Spacing.medium,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// where would you like go?
              const CommonText(
                text: "Where would you like go?",
                fontWeight: FontWeight.bold,
                fontSize: Spacing.large,
              ),
              const Gap(Spacing.medium),

              /// source address and destination address
              Row(
                children: [

                  Column(
                    children: [
                      SvgPicture.asset(CommonSvg.sourceLocation),
                      CustomPaint(
                        size: const Size(10,60),
                        painter: LinearPainter(),
                      ),
                      SvgPicture.asset(CommonSvg.destinationLocation)
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsetsDirectional.only(start: Spacing.xSmall),
                    child: Column(
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width/1.2,
                            child: CommonTextField(
                              controller: searchCubit.state.sourceAddressController,
                              hintText: "From",
                              onChanged: (val){
                                searchCubit.searchTextFieldEnable(textFieldEnable: 1);
                                if(val.trim().isNotEmpty){
                                  searchCubit.generateSessionKey(sessionKey: searchCubit.state.uuid.v4());
                                  searchCubit.searchLocation(searchLocation: val);
                                  searchCubit.isPlaceListIsEmpty(isPlaceListEmpty: true);
                                }else{
                                  searchCubit.clearList();
                                }
                              },
                            )
                        ),

                        const Gap(Spacing.medium + Spacing.small),
                        SizedBox(
                            width: MediaQuery.of(context).size.width/1.2,
                            child: CommonTextField(
                            controller: searchCubit.state.destinationAddressController,
                            hintText: "To",
                            suffixIcon: GestureDetector(
                              onTap: () async{
                                if(searchCubit.state.sourceAddressController.text.isNotEmpty && searchCubit.state.destinationAddressController.text.isNotEmpty){
                                  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                                  sharedPreferences.setString('mapTopBarValue','1');
                                  sharedPreferences.setString('from', searchCubit.state.sourceAddressController.text);
                                  sharedPreferences.setString('to', searchCubit.state.destinationAddressController.text).then((value){
                                    Navigator.pop(context);
                                  });
                                }
                              },
                              child: const Icon(Icons.search),
                            ),
                            onChanged: (val){
                              searchCubit.searchTextFieldEnable(textFieldEnable: 2);
                              // _debouncer.run(() {
                              if(val.trim().isNotEmpty){
                                searchCubit.generateSessionKey(sessionKey: searchCubit.state.uuid.v4());
                                searchCubit.searchLocation(searchLocation: val);
                                searchCubit.isPlaceListIsEmpty(isPlaceListEmpty: true);
                              }else{
                                searchCubit.clearList();
                              }
                            },
                            //}
                          )
                        ),
                      ],
                    ),
                  )
                ],
              ),

              // if(searchCubit.state.sourceAddressController.text.trim().toString().isNotEmpty
              //     && searchCubit.state.destinationAddressController.text.trim().toString().isNotEmpty)...[
              //       const Gap(Spacing.medium + Spacing.small),
              //       Padding(
              //         padding: const EdgeInsetsDirectional.symmetric(horizontal: Spacing.xxLarge),
              //         child: SizedBox(
              //           width: MediaQuery.of(context).size.width,
              //           child: CommonElevatedButton(
              //             text: "Search",
              //             borderRadius: 10.0,
              //             onPressed: (){},
              //           ),
              //         ),
              //       ),
              // ],

              ///filter result by search
              Expanded(
                child: Container(
                  margin: const EdgeInsetsDirectional.only(top: Spacing.medium),
                  child: BlocBuilder<SearchCubit, SearchState>(
                    builder: (context, state) {
                      print("isPlaceListEmpty ====> ${state.isPlaceListEmpty}");
                      if(state.isPlaceListEmpty){
                        return ListView.separated(
                          itemCount: state.isPlaceListEmpty ? searchCubit.state.placeList.length : 0,
                          itemBuilder: (context, index){
                            return ListTile(
                              tileColor: Colors.black.withOpacity(0.1),
                              visualDensity: const VisualDensity(horizontal: -4),
                              leading: Image.asset(CommonPng.search, scale: Spacing.medium,),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusDirectional.circular(Spacing.xMedium)
                              ),
                              title: CommonText(
                                text: state.placeList[index]['description'],
                                textAlign: TextAlign.start,
                              ),
                              onTap: () async{
                                  searchCubit.setTextFieldText(location: state.placeList[index]['description']);
                              },
                            );
                          },
                          separatorBuilder: (context, index){
                            return const Gap(Spacing.xSmall);
                          },
                        );
                      }
                      else{
                        return Center(
                        child: CommonText(
                          text: "🔍 Search Place...",
                          textColor: CommonColor.black.withOpacity(0.6),
                          fontSize: Spacing.large - Spacing.xSmall,
                        ),
                        );
                      }
                    },
                  ),
                ),
              ),

            ],
          ),
        ),
      )
    );
  }
}

class LinearPainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
        ..color = CommonColor.grey
        ..strokeWidth = 2;

  canvas.drawLine(
    Offset(size.height/12, size.height/20),
    Offset(size.height/12, size.height/1),
    paint
  );
}

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}


/*class Debouncer{
  final int millisecond;
  Timer? timer;
  Debouncer({required this.millisecond});
  void run(VoidCallback action){
    if(timer != null){
      timer!.cancel();
    }
    timer = Timer(Duration(milliseconds: millisecond), action);
  }
}*/

/*if(val.toString().trim().isNotEmpty && searchCubit.state.sessionToken.isNotEmpty){
  searchCubit.searchLocation(searchLocation: val);
}
searchCubit.clearList();
print("destination textEditing value ====>${searchCubit.state.placeList.length}");
searchCubit.generateSessionKey(sessionKey: searchCubit.state.uuid.v4());*/



/// proglabs official
/// AIzaSyD6bh35rjR-FvgI0FYSFX_a1Z8zMaM22zg

//ok