import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:smart_city_traveller/common/common_colors.dart';
import 'package:smart_city_traveller/common/common_spacing.dart';
import 'package:smart_city_traveller/common/widget/common_text.dart';
import 'package:smart_city_traveller/common/widget/common_textfield.dart';
import 'package:smart_city_traveller/ui/search/search_cubit.dart';
import 'package:smart_city_traveller/ui/search/search_state.dart';

class SearchUi extends StatefulWidget {
  const SearchUi({super.key});

  static const String routeName = "/search_ui";

  static Widget builder(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as String?;
    print("search adrees ====> ${args}");
    return BlocProvider(
      create: (context) =>
          SearchCubit(SearchState(
              sourceAddressController: TextEditingController(),
              destinationAddressController: TextEditingController(),
              address: args ?? ""
              // latLng: args
          )),
      child: const SearchUi(),
    );
  }

  @override
  State<SearchUi> createState() => _SearchUiState();
}

class _SearchUiState extends State<SearchUi> {

  SearchCubit get searchCubit => context.read<SearchCubit>();

  // @override
/*  void initState() {
    super.initState();
    searchCubit.state.destinationAddressController.addListener(() {
      if(searchCubit.state.sessionToken.isEmpty){
        searchCubit.generateSessionKey(sessionKey: searchCubit.state.uuid.v4());
      }
      // getSuggestion(searchCubit.state.destinationAddressController.text);
      searchCubit.searchLocation(searchLocation: searchCubit.state.destinationAddressController.text);
    });
  }*/

/*  void getSuggestion(String searchLocation) async{
    String kPLACE_API_KEY = "AIzaSyDQ2c_pOSOFYSjxGMwkFvCVWKjYOM9siow";
    String baseUrl = "https://maps.googleapis.com/maps/api/place/autocomplete/json";
    String request = "$baseUrl?input=$searchLocation&key=$kPLACE_API_KEY&sessiontoken=${searchCubit.state.sessionToken}";
    print("enable===> ");
    final response = await Dio().get(request);
    if(response.statusCode == 200){
        print("resp data =====> ${response.data}");
    }else{
      print("something wrong");
    }
  }*/

  @override
  Widget build(BuildContext context) {
    // searchCubit.setSourceAddress();
    return SafeArea(
      child: Scaffold(
        body: Padding(
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
                      const Icon(Icons.my_location, color: CommonColor.darkBlue,),
                      CustomPaint(
                        size: const Size(10,60),
                        painter: LinearPainter(),
                      ),
                      const Icon(Icons.location_on, color: CommonColor.darkBlue,),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsetsDirectional.only(start: Spacing.xSmall),
                    child: Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width/1.2,
                          child: BlocBuilder<SearchCubit, SearchState>(
                          builder: (context, state) {
                            return CommonTextField(
                            controller: state.sourceAddressController,
                            hintText: "Source Address",
                            suffixIcon: Icons.cancel,
                            suffixIconOnTap: (){
                              searchCubit.clearList();
                              state.sourceAddressController.clear();
                            },
                            onChanged: (String val){
                              if(val.trim().isEmpty){
                                searchCubit.clearList();
                                print("if ===> ${state.placeList.length}");
                              }else{
                                searchCubit.searchLocation(searchLocation: val);
                                searchCubit.generateSessionKey(sessionKey: state.uuid.v4());
                                print("else ===> ${state.placeList.length}");
                              }
                            },
                          );
                          },
                        ),
                        ),

                        const Gap(Spacing.medium + Spacing.small),
                        SizedBox(
                            width: MediaQuery.of(context).size.width/1.2,
                            child: CommonTextField(
                              controller: searchCubit.state.destinationAddressController,
                              hintText: "Destination Address",
                              suffixIcon: Icons.cancel,
                              suffixIconOnTap: () {
                                searchCubit.clearList();
                                searchCubit.state.destinationAddressController.clear();
                              },
                              onChanged: (val){
                                if(val.toString().trim().isNotEmpty && searchCubit.state.sessionToken.isNotEmpty){
                                  searchCubit.searchLocation(searchLocation: val);
                                }
                                searchCubit.clearList();
                                print("destination textEditing value ====>${searchCubit.state.placeList.length}");
                                searchCubit.generateSessionKey(sessionKey: searchCubit.state.uuid.v4());
                              },
                            )
                        ),
                      ],
                    ),
                  )
                ],
              ),

              ///filter result by search
              Expanded(
                child: Container(
                  margin: const EdgeInsetsDirectional.only(top: Spacing.medium),
                  child: BlocBuilder<SearchCubit, SearchState>(
                    builder: (context, state) {
                      return ListView.separated(
                        itemCount: searchCubit.state.placeList.length,
                        itemBuilder: (context, index){

                          if(state.placeList.isEmpty){
                            return const Center(child: CommonText(text: "Search Place..."),);
                          }else{
                            return ListTile(
                              visualDensity: const VisualDensity(vertical: -4, horizontal: -2),
                              leading: const Icon(Icons.location_on_sharp, color: CommonColor.green,),
                              title: CommonText(
                                text: state.placeList[index]['description'],
                                textAlign: TextAlign.start,
                              ),
                              onTap: (){

                              },
                            );
                          }

                        },
                        separatorBuilder: (context, index){
                          return const Divider(height: Spacing.small, color: CommonColor.grey,);
                        },
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        )
      ),
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
    Offset(size.height/12, size.height/14),
    Offset(size.height/12, size.height/1),
    paint
  );
}

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

/// proglabs official
/// AIzaSyD6bh35rjR-FvgI0FYSFX_a1Z8zMaM22zg