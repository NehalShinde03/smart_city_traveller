import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_city_traveller/common/common_colors.dart';
import 'package:smart_city_traveller/common/common_spacing.dart';
import 'package:smart_city_traveller/common/widget/common_textfield.dart';
import 'package:smart_city_traveller/ui/home/home_cubit.dart';
import 'package:smart_city_traveller/ui/home/home_state.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeUi extends StatefulWidget {
  const HomeUi({super.key});

  static const String routeName = '/home_ui';

  static Widget builder(BuildContext context) =>
      BlocProvider(
        create: (context) =>
            HomeCubit(HomeState(
                searchController: TextEditingController(),
                googleMapController: Completer<GoogleMapController>(),
            )),
        child: const HomeUi(),
      );

  @override
  State<HomeUi> createState() => _HomeUiState();
}

class _HomeUiState extends State<HomeUi> {

  HomeCubit get homeCubit => context.read<HomeCubit>();

  @override
  Widget build(BuildContext context) {

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
      body: BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Stack(
        children: [
          /*  Padding(
            padding: const EdgeInsetsDirectional.only(
              start: Spacing.medium,
              end: Spacing.medium,
              top: Spacing.medium,
              bottom: Spacing.small
            ),
            child: CommonTextField(
                controller: homeCubit.state.searchController,
                suffixIcon: Icons.search,
                hintText: "Search here",
                prefixImagePath: CommonPng.googleMap,
              // prefixIcon: ,
            ),
          ),*/

          Flexible(
              child: GoogleMap(
                initialCameraPosition: const CameraPosition(
                  target: LatLng(21.071425, 72.878488),
                  zoom: 13.0,
                ),
                onMapCreated: (GoogleMapController controller) {
                  state.googleMapController.complete(controller);
                },
                // buildingsEnabled: true,
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                compassEnabled: true,
                markers: {
                  const Marker(
                      markerId: MarkerId('111'),
                      icon: BitmapDescriptor.defaultMarker,
                      position: LatLng(21.071425, 72.878488)
                  )
                },
                padding: const EdgeInsets.only(
                  top: Spacing.xxxLarge * 15.2
                ),
                zoomControlsEnabled: false,
                // mapType: MapType.normal,
                // trafficEnabled: true,
                // mapToolbarEnabled: true,
              )
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
                bottom: Spacing.small,
                end: Spacing.small,
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width/7.5,
                height: MediaQuery.of(context).size.height/15,
                child: FloatingActionButton(
                  onPressed: () => homeCubit.isDirectionIconClick(isDirectionIconClick: !state.isDirectionIconClick),
                  backgroundColor: CommonColor.darkBlue,
                  child: const Icon(Icons.directions_sharp, color: CommonColor.white, size: Spacing.xxxLarge,),
                ),
              ),
            ),
          )

        ],
      );
  },
),
    );
  }
}
