import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
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

  @override
  void initState() {
    super.initState();
    // searchCubit.setSourceAddress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          searchCubit.setSourceAddress();
          return Padding(
            padding: const EdgeInsetsDirectional.only(
                start: Spacing.medium,
                end: Spacing.medium,
                top: Spacing.large,
                // bottom: Spacing.small
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisSize: MainAxisSize.max,
              children: [
                const CommonText(
                  text: "Where would you like go?",
                  fontWeight: FontWeight.bold,
                  fontSize: Spacing.large,
                ),


                Stepper(
                  margin: const EdgeInsetsDirectional.only(
                    start: Spacing.xxxLarge + Spacing.small,
                    end: Spacing.medium,
                  ),
                  controlsBuilder: (context, controller) {
                    return const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox.shrink(),
                        SizedBox.shrink(),
                      ],
                    );
                  },
                  steps: [
                    Step(
                      title: const Icon(Icons.share_location),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CommonText(
                            text: "From",
                            fontWeight: FontWeight.bold,
                            fontSize: Spacing.large,
                          ),
                          CommonTextField(
                            controller: state.sourceAddressController,
                            hintText: "Source Address",
                            prefixIcon: Icons.my_location_rounded,
                            suffixIcon: Icons.cancel,
                            suffixIconOnTap: () => state.sourceAddressController.clear(),
                          ),
                        ],
                      ),
                    ),

                    Step(
                      title: const Icon(Icons.location_on_sharp),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CommonText(
                            text: "To",
                            fontWeight: FontWeight.bold,
                            fontSize: Spacing.large,
                          ),
                          CommonTextField(
                            controller: state.destinationAddressController, // Use a different controller
                            hintText: "Destination Address",
                            prefixIcon: Icons.location_on_sharp,
                            suffixIcon: Icons.cancel,
                            suffixIconOnTap: () => state.destinationAddressController.clear(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                /*CommonTextField(
                  controller: state.sourceAddressController,
                  hintText: "Destination Address",
                  prefixIcon: Icons.my_location_rounded,
                  suffixIcon: Icons.cancel,
                  suffixIconOnTap: () => state.sourceAddressController.clear(),
                ),*/
              /*  const Gap(Spacing.xxLarge),*/

                SizedBox()

                /*const Gap(Spacing.xMedium),
                CommonTextField(
                  controller: state.destinationAddressController,
                  hintText: "Destination Address",
                  prefixIcon: Icons.share_location_sharp,
                  suffixIcon: Icons.cancel,
                  suffixIconOnTap: () => state.destinationAddressController.clear(),
                ),*/

                /*Expanded(
                    child: Container(color: Colors.red,),
                )*/
              ],
            ),
          );
        },
      ),
    );
  }
}
