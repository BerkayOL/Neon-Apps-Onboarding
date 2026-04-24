import 'package:flutter/material.dart';

import '../theme/app_constants.dart';

class CustomHulkTabBar extends StatelessWidget {
  const CustomHulkTabBar({
    super.key,
    required this.selectedIndex,
    required this.icons,
    required this.titles,
    required this.onTap,
  });

  final int selectedIndex;
  final List<IconData> icons;
  final List<String> titles;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: kTabBarBottomMargin),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(kTabBarBackgroundOpacity),
        borderRadius: BorderRadius.circular(kTabBarRadius),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: kTabBarShadowBlurRadius,
            offset: kTabBarShadowOffset,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: kTabBarVerticalPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(icons.length, (index) {
          final bool isSelected = selectedIndex == index;
          return InkWell(
            onTap: () => onTap(index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icons[index],
                  color: isSelected ? Colors.green : Colors.grey,
                ),
                Text(
                  titles[index],
                  style: TextStyle(
                    color: isSelected ? Colors.green : Colors.grey,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
