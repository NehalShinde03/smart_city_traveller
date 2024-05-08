import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_city_traveller/common/common_colors.dart';
import 'package:smart_city_traveller/common/common_spacing.dart';
import 'package:smart_city_traveller/common/widget/common_text.dart';
import 'package:smart_city_traveller/common/widget/common_textfield.dart';
import 'package:smart_city_traveller/ui/home/home_cubit.dart';
import 'package:smart_city_traveller/ui/home/home_state.dart';
import 'package:smart_city_traveller/ui/search/search_ui.dart';

class HomeUi extends StatefulWidget {
  const HomeUi({super.key});

  static const String routeName = '/home_ui';

  static Widget builder(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(HomeState(
          searchController: TextEditingController(),
          googleMapController: Completer<GoogleMapController>(),
          latLag: const LatLng(0.0, 0.0))),
      child: const HomeUi(),
    );
  }

  @override
  State<HomeUi> createState() => _HomeUiState();
}

class _HomeUiState extends State<HomeUi> with WidgetsBindingObserver {
  HomeCubit get homeCubit => context.read<HomeCubit>();

  @override
  void initState() {
    super.initState();
    homeCubit.initSharedPreferences();
    if (homeCubit.state.mapTopBarValue == "0") {
      homeCubit.fetchCurrentLocation();
    }
  }

  // @override
  // void dispose() {
  //   homeCubit.state.searchController.dispose();
  //   homeCubit.state.googleMapController.future.then((value) => value.dispose());
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
              return Container(
                padding: const EdgeInsetsDirectional.only(
                    top: Spacing.xSmall,
                    end: Spacing.small,
                    start: Spacing.small,
                    bottom: Spacing.xSmall - 2),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 11,
                child: optionWidget(state),
              );
            }),
            Flexible(
              child: Stack(
                children: [
                  BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      return GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: state.latLag,
                          zoom: 7.0,
                        ),
                        onMapCreated: (GoogleMapController controller) {
                          state.googleMapController.complete(controller);
                        },
                        buildingsEnabled: true,
                        myLocationEnabled:
                            state.mapTopBarValue == '0' ? true : false,
                        myLocationButtonEnabled:
                            state.mapTopBarValue == '0' ? false : true,
                        compassEnabled: true,
                        markers: state.setMarkers,
                        zoomControlsEnabled: false,
                        trafficEnabled: true,
                        mapToolbarEnabled: false,
                        polylines: state.mapTopBarValue == '0' ? {} : (state.setPolyLine),
                      );
                      },
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(
                        end: Spacing.medium,
                        bottom: Spacing.medium,
                      ),
                      child: BlocBuilder<HomeCubit, HomeState>(
                        builder: (context, state) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (state.mapTopBarValue == '0') ...[
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
                                )
                              ] else ...[
                                const SizedBox.shrink()
                              ],
                              const Gap(Spacing.medium),
                              FloatingActionButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, SearchUi.routeName, arguments: state.address).then((value) {
                                    homeCubit.initSharedPreferences();
                                  });
                                },
                                backgroundColor: CommonColor.darkBlue,
                                child: const Icon(
                                  Icons.directions_sharp,
                                  color: CommonColor.white,
                                  size: Spacing.xxxLarge,
                                ),
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget optionWidget(HomeState state) {
    print("onTapValue ====> ${state.mapTopBarValue}");
    print("setMarkers ====> ${state.setMarkers}");
    if (state.mapTopBarValue == "1") {
      homeCubit.addPolyLine(state.sourceAddress, state.destinationAddress);
      return Container(
          padding: const EdgeInsetsDirectional.only(
            top: Spacing.xSmall,
            end: Spacing.small,
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 11,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () async {
                  homeCubit.setMapTopBarValue(topBarValue: '0');
                },
                icon: Icon(
                  Icons.close,
                  color: CommonColor.black.withOpacity(0.8),
                  size: Spacing.large,
                ),
                style: const ButtonStyle(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                padding: PaddingValue.zero,
                constraints: const BoxConstraints(),
              ),
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: Spacing.small),
                  children: [
                    CommonText(
                      text: "From: ${state.sourceAddress}",
                      textAlign: TextAlign.start,
                      fontWeight: TextWeight.semiBold,
                    ),
                    CommonText(
                      text: "To: ${state.destinationAddress}",
                      textAlign: TextAlign.start,
                      fontWeight: TextWeight.semiBold,
                    ),
                  ],
                ),
              )
            ],
          ));
    } else if (state.mapTopBarValue == "2") {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Padding(
            padding: EdgeInsetsDirectional.only(
                // start: Spacing.xxxLarge * 2,
                end: Spacing.xLarge,
                top: Spacing.large),
            child: CommonText(
              text: "Remaining Time:: 2h:44m:22s",
              fontSize: Spacing.large,
              textAlign: TextAlign.center,
            ),
          ),
          IconButton(
            onPressed: () async {
              homeCubit.setMapTopBarValue(topBarValue: '0');
            },
            icon: Icon(
              Icons.close,
              color: CommonColor.black.withOpacity(0.8),
              size: Spacing.large,
            ),
            style: const ButtonStyle(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            padding: PaddingValue.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      );
    } else {
      homeCubit.fetchCurrentLocation();
      return Padding(
        padding: const EdgeInsetsDirectional.only(top: Spacing.xSmall,),
        child: CommonTextField(
          controller: state.searchController,
        ),
      );
    }
  }
}

//ok