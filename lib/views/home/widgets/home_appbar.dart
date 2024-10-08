import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pixabay_gallery/config/assets/image_assets.dart';
import 'package:pixabay_gallery/config/theme/colors.dart';
import 'package:pixabay_gallery/config/theme/text_theme_style.dart';
import 'package:pixabay_gallery/utils/gaps.dart';
import 'package:pixabay_gallery/utils/utils.dart';

class HomeAppbar extends HookConsumerWidget {
  const HomeAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverAppBar(
      pinned: true, // Keep the AppBar pinned at the top when scrolling
      expandedHeight: 230.0,
      collapsedHeight: Utils.getScreenHeight(context) * 0.08,
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          var appBarHeight = constraints.biggest.height;
          var isCollapsed = appBarHeight <= 150;
          return Container(
            // Gradient background always visible
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(isCollapsed ? 0 : 30),
                bottomRight: Radius.circular(isCollapsed ? 0 : 30),
              ),
              gradient: const LinearGradient(
                colors: [
                  AppColors.primaryColor,
                  AppColors.secondaryColor,
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon and picture row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 40,
                        height: 40,
                        child: Material(
                          color: AppColors.secondaryColor,
                          borderRadius: BorderRadius.circular(10),
                          child: const Icon(
                            Icons.grid_view_outlined,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      Material(
                        color: AppColors.yelow,
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          ImageAssets.userPic,
                          fit: BoxFit.cover,
                          height: 40,
                          width: 40,
                        ),
                      ),
                    ],
                  ),
                  // Show text only when the app bar is expanded
                  if (!isCollapsed) ...[
                    Gaps.verticalGapOf(30),
                    Flexible(
                      child: Text(
                        'Hello there,\nGood Day!',
                        style:
                            AppTextStyles.textHeading(color: AppColors.white),
                      ),
                    ),
                  ]
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
