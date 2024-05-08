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

/*  Future<void> addPolyLine(String sourceAddress, String destinationAddress) async {
      print("add poly Line source =====> $sourceAddress");
      print("add poly Line destination =====> $destinationAddress");
    final convertAddressToCoordinates = await locationFromAddress(state.destinationAddress);
    final destination = LatLng(convertAddressToCoordinates.last.latitude, convertAddressToCoordinates.last.longitude);
    List<LatLng> polyLineCoordinates = [state.latLag, destination];

    print("point 1 ====> ${state.latLag}");
    print("point 2 ====> $destination");

    Polyline polyline = Polyline(
        polylineId: const PolylineId("poly"),
        points: polyLineCoordinates,
        width: 5,
        color: CommonColor.blue
    );

    Set<Polyline> setPolyLine = {polyline};
    // setPolyLine.add(polyline);
    emit(state.copyWith(setPolyLine: setPolyLine));

    // GoogleMapController googleMapController = await state.googleMapController.future;
    // googleMapController.animateCamera(
    //   CameraUpdate.newLatLngBounds(
    //     LatLngBounds(
    //         southwest: destination,
    //         northeast: source,
    //     ), 50
    //   )
    // );
  }*/

/*Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
              child: Padding(
            padding: const EdgeInsetsDirectional.only(top: Spacing.xSmall),
            child: CommonTextField(controller: state.searchController),
          )),
          const Gap(Spacing.xSmall),
          IconButton(
            onPressed: () => print("hello"),
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
      );*/