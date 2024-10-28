import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixabay_gallery/config/assets/image_assets.dart';
import 'package:pixabay_gallery/config/theme/colors.dart';
import 'package:pixabay_gallery/config/theme/text_theme_style.dart';
import 'package:pixabay_gallery/utils/gaps.dart';
import 'package:pixabay_gallery/view%20model/gallery%20viewmodel/gallery_viewmodel.dart';

class PhotosListBuilder extends ConsumerWidget {
  const PhotosListBuilder({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final galleryState = ref.watch(galleryProvider);

    return GridView.builder(
      shrinkWrap: true,
      itemCount: galleryState.galleryList.length +
          (galleryState.hasMore && !galleryState.isLoading ? 1 : 0),
      primary: false,
      physics: const ClampingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        crossAxisSpacing: 15,
        mainAxisSpacing: 30,
        mainAxisExtent: 200,
      ),
      itemBuilder: (context, index) {
        final photo = galleryState.galleryList[index];
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.white,
            image: DecorationImage(
              image: CachedNetworkImageProvider(
                  photo.previewURL ?? ImageAssets.naturePic),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.blackLight.withOpacity(0.4),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.favorite, color: AppColors.white),
                          Gaps.horizontalGapOf(5),
                          Text(
                            '${photo.likes}',
                            style: AppTextStyles.textCaption(
                                color: AppColors.white),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.visibility_rounded,
                              color: AppColors.white),
                          Gaps.horizontalGapOf(5),
                          Text(
                            '${photo.views}',
                            style: AppTextStyles.textCaption(
                                color: AppColors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
