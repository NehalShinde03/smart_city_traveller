import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_city_traveller/common/common_colors.dart';
import 'package:smart_city_traveller/common/common_spacing.dart';
import 'package:smart_city_traveller/common/widget/common_text.dart';
import 'package:smart_city_traveller/ui/home/home_cubit.dart';
import 'package:smart_city_traveller/ui/home/home_state.dart';
import 'package:smart_city_traveller/ui/search/search_ui.dart';

class HomeUi extends StatefulWidget {
  const HomeUi({super.key});

  static const String routeName = '/home_ui';

  static Widget builder(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HomeCubit(HomeState(
              searchController: TextEditingController(),
              googleMapController: Completer<GoogleMapController>(),
              latLag: const LatLng(0.0, 0.0)
          )),
      child: const HomeUi(),
    );
  }

  @override
  State<HomeUi> createState() => _HomeUiState();
}

class _HomeUiState extends State<HomeUi> {

  HomeCubit get homeCubit => context.read<HomeCubit>();

  @override
  void initState() {
    super.initState();
    // homeCubit.fetchCurrentLocation();
    homeCubit.initSharedPreferences();
    print("source ====> ${homeCubit.state.sourceAddress}");
    print("destination ====> ${homeCubit.state.destinationAddress}");
  }

  @override
  Widget build(BuildContext context) {
    homeCubit.fetchCurrentLocation();

    return Scaffold(
      /*drawer: Drawer(
        backgroundColor: CommonColor.black.withOpacity(0.8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              return Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff3BB2B8), Color(0xff17EAD9)]
                )
              ),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/4,
              padding: const EdgeInsetsDirectional.symmetric(
                horizontal: Spacing.small
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: CommonColor.black.withOpacity(0.8),
                    radius: Spacing.xxLarge + Spacing.small,
                    child: const Icon(Icons.person, color: CommonColor.white, size: Spacing.xxxLarge+Spacing.medium,),
                  ),
                  const Gap(Spacing.medium),
                  CommonText(
                    text: state.userInfo.first,
                    textColor: CommonColor.white,
                    fontSize: Spacing.large - Spacing.xSmall,
                    fontWeight: FontWeight.bold,
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                      bottom: Spacing.small
                    ),
                    child: CommonText(
                      text: state.userInfo.last,
                      textColor: CommonColor.white,
                      fontSize: Spacing.medium,
                    ),
                  )
                ],
              ),
            );
            },
          ),
            BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              return ListView.separated(
              shrinkWrap: true,
              itemCount: 3,
              padding: PaddingValue.zero,
              itemBuilder: (context, index){
                return ListTile(
                  title: Row(
                    children: [
                      Icon(state.drawerItemIcon[index], color: CommonColor.white.withOpacity(0.8), size: Spacing.large,),
                      const Gap(Spacing.xMedium),
                      CommonText(
                        text: DrawerItem.values[index].name,
                        textColor: CommonColor.white,
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                  onTap: (){
                    print("drawer item tap =====> ${index}");
                    Scaffold.of(context).closeDrawer();
                  },
                );
              },
              separatorBuilder: (context, index){
                return const Divider(
                  color: CommonColor.white,
                  height: 0,
                );
              },
            );
            },
          )
          ],
        ),
      ),*/
      body: SafeArea(
        child: Column(
          children: [

            Card(
              color: CommonColor.teal.withOpacity(0.7),
              elevation: 5,
              child: Container(
                padding: PaddingValue.small,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/11,
                child: BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    return SingleChildScrollView(
                      child: Align(
                        alignment: AlignmentDirectional.bottomCenter,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const CommonText(
                                  text: "From: ",
                                  fontWeight: FontWeight.bold,
                                ),
                                CommonText(
                                  text: state.sourceAddress,
                                  textAlign: TextAlign.start,
                                )
                              ],
                            ),
                            const Gap(Spacing.xSmall - 2),
                            Row(
                              children: [
                                const CommonText(
                                  text: "To: ",
                                  fontWeight: FontWeight.bold,
                                ),
                                CommonText(
                                  text: state.destinationAddress,
                                  textAlign: TextAlign.start,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            Flexible(
              child: Stack(
                children: [

                  BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      print("called");
                      return GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: state.latLag,
                          zoom: 7.0,
                        ),
                        onMapCreated: (GoogleMapController controller) {
                          state.googleMapController.complete(controller);
                        },
                        buildingsEnabled: true,
                        myLocationEnabled: true,
                        myLocationButtonEnabled: false,
                        compassEnabled: true,
                        markers: {
                          Marker(
                            markerId: const MarkerId('1'),
                            icon: BitmapDescriptor.defaultMarker,
                            position: state.latLag,
                            infoWindow: InfoWindow(
                              title: state.address,
                            ),
                          )
                        },
                        zoomControlsEnabled: false,
                        trafficEnabled: true,
                        mapToolbarEnabled: false,
                      );
                    },
                  ),

                  /* state.isDirectionIconClick
                  ? Container(
                    color: CommonColor.white,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                              start: Spacing.medium,
                              end: Spacing.medium,
                              top: Spacing.medium,
                              bottom: Spacing.small
                          ),
                          child: CommonTextField(
                            controller: homeCubit.state.searchController,
                            // suffixIcon: Icons.search,
                            hintText: "Source Address",
                            // prefixImagePath: CommonPng.googleMap,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                              start: Spacing.medium,
                              end: Spacing.medium,
                              top: Spacing.xSmall,
                              bottom: Spacing.small
                          ),
                          child: CommonTextField(
                            controller: homeCubit.state.searchController,
                            // suffixIcon: Icons.search,
                            hintText: "Destination Address",
                            // prefixImagePath: CommonPng.googleMap,
                            // prefixIcon: ,
                          ),
                        ),
                      ],
                    ),
                  )
                  : SizedBox(),
              */

                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(
                        end: Spacing.medium,
                        bottom: Spacing.medium,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [

                          GestureDetector(
                            onTap: () => homeCubit.fetchCurrentLocation(),
                            child: const CircleAvatar(
                              radius: Spacing.xxLarge,
                              backgroundColor: CommonColor.white,
                              child: Icon(
                                Icons.my_location,
                                color: CommonColor.darkBlue,
                              ),
                            ),
                          ),

                          const Gap(Spacing.medium),

                          FloatingActionButton(
                            onPressed: () {
                              Navigator.pushNamed(context, SearchUi.routeName, arguments: homeCubit.state.address).then((value) {
                                homeCubit.initSharedPreferences();
                              });
                            },
                            backgroundColor: CommonColor.darkBlue,
                            child: const Icon(Icons.directions_sharp, color: CommonColor.white, size: Spacing.xxxLarge,),
                          ),
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}
