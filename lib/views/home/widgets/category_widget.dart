import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixabay_gallery/config/theme/text_theme_style.dart';
import 'package:pixabay_gallery/utils/app_constants.dart';
import 'package:pixabay_gallery/utils/gaps.dart';
import 'package:pixabay_gallery/view%20model/gallery%20viewmodel/gallery_viewmodel.dart';

class CategoryWidget extends ConsumerWidget {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 130,
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) => Gaps.horizontalGapOf(20),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        primary: false,
        itemCount: AppConstants.categoryList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async {
              await ref.read(galleryProvider.notifier).updateCategory(
                  AppConstants.categoryList[index].categoryName.toLowerCase());
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    AppConstants.categoryList[index].categoryImage,
                    height: 80,
                    width: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                Gaps.verticalGapOf(10),
                Text(
                  AppConstants.categoryList[index].categoryName,
                  style: AppTextStyles.textLabel(),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
