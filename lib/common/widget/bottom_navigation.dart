import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:smart_city_traveller/common/common_colors.dart';
import 'package:smart_city_traveller/common/common_spacing.dart';
import 'package:smart_city_traveller/common/widget/enum.dart';
import 'common_text.dart';

class BottomNavBar extends StatelessWidget {
  final BottomNavigationOption selectedTab;
  final ValueSetter<BottomNavigationOption> onTabChanged;

  const BottomNavBar({
    super.key,
    required this.selectedTab,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: CommonColor.black,
        height: kBottomNavigationBarHeight,
        // height: kBottomNavigationBarHeight + Spacing.xxLarge,
        padding: const EdgeInsets.only(top: Spacing.small),
        // decoration: const BoxDecoration(
        //   image: DecorationImage(
        //       image: AssetImage(AppImages.tabBar), fit: BoxFit.fill),
        // ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BottomNavIcon(
              activeIcon: Icons.home_outlined,
              inactiveIcon: Icons.home_outlined,
              label: "Home",
              isSelected: selectedTab == BottomNavigationOption.home,
              value: BottomNavigationOption.home,
              onTabChanged: onTabChanged,
            ),
           BottomNavIcon(
              activeIcon: Icons.schedule,
              inactiveIcon: Icons.schedule,
              label: "Schedule Plan",
              isSelected: selectedTab == BottomNavigationOption.schedulePlan,
              value: BottomNavigationOption.schedulePlan,
              onTabChanged: onTabChanged,
            ),
            BottomNavIcon(
              activeIcon: Icons.room_outlined,
              inactiveIcon: Icons.room_outlined,
              label: "View Plan",
              isSelected: selectedTab == BottomNavigationOption.viewPlan,
              value: BottomNavigationOption.viewPlan,
              onTabChanged: onTabChanged,
            ),
            BottomNavIcon(
              activeIcon: Icons.person_2_outlined,
              inactiveIcon: Icons.person_2_outlined,
              label: "Profile",
              isSelected: selectedTab == BottomNavigationOption.profile,
              value: BottomNavigationOption.profile,
              onTabChanged: onTabChanged,
            ),
          ],
        ),
      ),
    );
  }
}

class BottomNavIcon extends StatelessWidget {
  final IconData? activeIcon;
  final IconData? inactiveIcon;
  final String label;
  final bool isSelected;
  final BottomNavigationOption value;
  final ValueSetter<BottomNavigationOption> onTabChanged;

  const BottomNavIcon({
    super.key,
    this.activeIcon,
    this.inactiveIcon,
    required this.label,
    required this.value,
    required this.isSelected,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: () => onTabChanged.call(value),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Icon(isSelected ? activeIcon : inactiveIcon,
            color: isSelected ? CommonColor.white : CommonColor.grey.withOpacity(0.7),),

          const Gap(6),
          CommonText(
            text: label,
            textColor: isSelected ? CommonColor.white : CommonColor.grey,
            fontSize: 12,
            fontWeight: FontWeight.w500,
            // letterSpacing: 0.8,
          )
        ],
      ),
    );
  }
}
