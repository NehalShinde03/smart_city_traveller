import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_city_traveller/common/common_images.dart';

class OnBoardingState extends Equatable {
  final List imageList;
  final List<String> title;
  final List<String> description;
  final PageController pageController;
  final double opacityValue;
  final Alignment titleAlignment;
  final Alignment descriptionAlignment;
  final int index;

  const OnBoardingState(
      {this.imageList = const [
        CommonPng.onBoardingSecond,
        CommonPng.onBoardingThree
      ],
      this.title = const [
        "Nearby Places",
        "Time Manage",
      ],
      this.description = const [
        "All nearby venues will show\naccording to the time you give.",
        "Prepare a plan according\nto your schedule.",
      ],
      required this.pageController,
      this.opacityValue = 0.0,
      this.titleAlignment = Alignment.topLeft,
      this.descriptionAlignment = Alignment.topRight,
      this.index = 0});

  @override
  List<Object?> get props => [
        imageList,
        pageController,
        title,
        description,
        opacityValue,
        titleAlignment,
        descriptionAlignment,
        index
      ];

  OnBoardingState copyWith(
      {List? imageList,
      List<String>? title,
      List<String>? description,
      PageController? pageController,
      double? opacityValue,
      Alignment? titleAlignment,
      Alignment? descriptionAlignment,
      int? index}) {
    return OnBoardingState(
        imageList: imageList ?? this.imageList,
        title: title ?? this.title,
        description: description ?? this.description,
        pageController: pageController ?? this.pageController,
        opacityValue: opacityValue ?? this.opacityValue,
        titleAlignment: titleAlignment ?? this.titleAlignment,
        descriptionAlignment: descriptionAlignment ?? this.descriptionAlignment,
        index: index ?? this.index);
  }
}
