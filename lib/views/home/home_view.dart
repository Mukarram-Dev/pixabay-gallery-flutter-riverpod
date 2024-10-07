import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pixabay_gallery/utils/gaps.dart';
import 'package:pixabay_gallery/view%20model/gallery%20viewmodel/gallery_viewmodel.dart';
import 'package:pixabay_gallery/views/home/widgets/category_widget.dart';
import 'package:pixabay_gallery/views/home/widgets/custom_search_widget.dart';
import 'package:pixabay_gallery/views/home/widgets/home_appbar.dart';
import 'package:pixabay_gallery/views/home/widgets/photos_list_builder.dart';

class HomeView extends HookConsumerWidget {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final galleryState = ref.watch(galleryProvider);
    final searchController = useTextEditingController();
    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollInfo) {
          if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
              !galleryState.isLoading &&
              !galleryState.hasMore) {
            ref.read(galleryProvider.notifier).fetchGalleryList();
          }
          return false;
        },
        child: CustomScrollView(slivers: [
          const HomeAppbar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Gaps.verticalGapOf(30),
                  CustomSearchWidget(
                    controller: searchController,
                    textInputType: TextInputType.text,
                    hintTitle: 'Search Photos',
                    onTap: () {
                      ref
                          .read(galleryProvider.notifier)
                          .updateSearchQuery(searchController.text);
                      searchController.clear();
                    },
                  ),
                  Gaps.verticalGapOf(40),
                  const CategoryWidget(),
                  const PhotosListBuilder(),
                  if (galleryState.hasMore) ...[
                    Gaps.verticalGapOf(30),
                    const Align(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator())
                  ]
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
