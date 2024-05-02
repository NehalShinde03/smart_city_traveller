import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:smart_city_traveller/common/common_colors.dart';
import 'package:smart_city_traveller/common/common_spacing.dart';
import 'package:smart_city_traveller/common/widget/common_text.dart';
import 'package:smart_city_traveller/ui/bottom_nav_bar/bottom_nav_bar_view.dart';
import 'package:smart_city_traveller/ui/on_bording_screen/on_boarding_cubit.dart';
import 'package:smart_city_traveller/ui/on_bording_screen/on_boarding_state.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingUi extends StatefulWidget {
  const OnBoardingUi({super.key});

  static const String routeName = '/on_boarding_ui.dart';
  static Widget builder(BuildContext context) => BlocProvider(
      create: (context) => OnBoardingCubit(OnBoardingState(
          pageController: PageController(),
      )),
      child: OnBoardingUi(),
  );

  @override
  State<OnBoardingUi> createState() => _OnBoardingUiState();
}

class _OnBoardingUiState extends State<OnBoardingUi> {

  OnBoardingCubit get onBoardingCubit => context.read<OnBoardingCubit>();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      onBoardingCubit.changeOpacity(opacityValue: 1.0);
      onBoardingCubit.changeAlignment(
          titleAlignment: Alignment.center,
          descriptionAlignment: Alignment.center
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<OnBoardingCubit, OnBoardingState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsetsDirectional.only(
                start: Spacing.medium,
                end: Spacing.medium,
                bottom: Spacing.xLarge
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  child: PageView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: state.pageController,
                      itemCount: 2,
                      onPageChanged: (index){
                        onBoardingCubit.updatePage(index: index);
                        Future.delayed(const Duration(milliseconds: 900), () {
                          onBoardingCubit.changeOpacity(opacityValue: 1.0);
                          onBoardingCubit.changeAlignment(
                              titleAlignment: Alignment.center,
                              descriptionAlignment: Alignment.center
                          );
                        });
                      },
                      itemBuilder: (context, index){
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AnimatedOpacity(
                              opacity: state.opacityValue,
                              duration: const Duration(milliseconds: 1500),
                              child: Image.asset(
                                state.imageList[index],
                                // width: MediaQuery.of(context).size.width/1.5,
                                scale: index == 0
                                ? Spacing.xSmall - 2.7
                                : Spacing.small - 6,
                              ),
                            ),

                            const Gap(Spacing.xxLarge),
                            AnimatedAlign(
                              alignment: state.titleAlignment,
                              duration: const Duration(milliseconds: 1800),
                              child: AnimatedOpacity(
                                  opacity: state.opacityValue,
                                  duration: const Duration(seconds: 2),
                                  child: CommonText(
                                    text: state.title[index],
                                    fontWeight: FontWeight.bold,
                                    fontSize: Spacing.xLarge,
                                  ),
                              ),
                            ),

                            AnimatedAlign(
                              alignment: state.descriptionAlignment,
                              duration: const Duration(milliseconds: 1800),
                              child: AnimatedOpacity(
                                opacity: state.opacityValue,
                                duration: const Duration(seconds: 2),
                                child: CommonText(
                                  text: state.description[index],
                                  fontWeight: FontWeight.w400,
                                  fontSize: Spacing.large - Spacing.xSmall,
                                ),
                              ),
                            ),

                          ],
                        );
                      }
                  ),
                ),

                /// indicator
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    bottom: Spacing.xxxLarge * 2,
                    top: Spacing.medium,
                  ),
                  child: AnimatedOpacity(
                    opacity: state.opacityValue,
                    duration: const Duration(seconds: 2),
                    child: SmoothPageIndicator(
                      controller: state.pageController,
                      effect: const WormEffect(
                        activeDotColor: CommonColor.teal,
                        strokeWidth: Spacing.xSmall,
                        dotWidth: Spacing.medium,
                        dotHeight: Spacing.medium,
                      ),
                      count: 2,
                    ),
                  ),
                ),

                Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: (){

                          onBoardingCubit.changeOpacity(opacityValue: 0.0);
                          onBoardingCubit.changeAlignment(
                              titleAlignment: Alignment.topLeft,
                              descriptionAlignment: Alignment.topRight,
                          );

                          state.index == 0 ? state.pageController.nextPage(
                            duration: const Duration(seconds: 1),
                            curve: Curves.easeInQuart,
                          )
                          : state.pageController.previousPage(
                            duration: const Duration(seconds: 1),
                            curve: Curves.easeInQuart,
                          );
                        },
                        child: AnimatedOpacity(
                          opacity: state.opacityValue,
                          duration: const Duration(seconds: 2),
                          child: CommonText(
                            text: state.index == 0 ? "Skip" : "Previous",
                            fontWeight: FontWeight.w400,
                            fontSize: Spacing.xMedium + Spacing.xSmall,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, BottomNavBarView.routeName),
                        // onTap: () => Navigator.pushNamed(context, HomeUi.routeName),
                        child: state.index == 0 ? const SizedBox()
                        : AnimatedOpacity(
                          opacity: state.opacityValue,
                          duration: const Duration(seconds: 2),
                          child: const CircleAvatar(
                            backgroundColor: Colors.black,
                            child: Icon(Icons.arrow_forward_sharp, color: CommonColor.white,),
                          ),
                        ),
                      )
                    ],
                  ),
                )

              ],
            ),
          );
        },
      ),
      ),
    );
  }
}
