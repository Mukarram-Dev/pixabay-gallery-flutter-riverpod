import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixabay_gallery/data/services/gallery%20services/gallery_services_impl.dart';
import 'package:pixabay_gallery/models/pixabay_model.dart';
import 'package:pixabay_gallery/utils/utils.dart';

final galleryProvider =
    StateNotifierProvider<GalleryViewmodel, GalleryModelState>(
  (ref) => GalleryViewmodel(ref),
);

class GalleryModelState {
  final List<Hits> galleryList;
  final String category;
  final String searchQuery;
  final int resultsLoad;
  final int pageLoad;
  final bool isLoading;
  final bool hasMore;

  GalleryModelState({
    required this.galleryList,
    required this.resultsLoad,
    required this.isLoading,
    required this.pageLoad,
    required this.hasMore,
    required this.category,
    required this.searchQuery,
  });

  GalleryModelState copyWith({
    List<Hits>? galleryList,
    String? category,
    String? searchQuery,
    int? resultsLoad,
    int? pageLoad,
    bool? isLoading,
    bool? hasMore,
  }) {
    return GalleryModelState(
      galleryList: galleryList ?? this.galleryList,
      resultsLoad: resultsLoad ?? this.resultsLoad,
      pageLoad: pageLoad ?? this.pageLoad,
      isLoading: isLoading ?? this.isLoading,
      hasMore: hasMore ?? this.hasMore,
      category: category ?? this.category,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

class GalleryViewmodel extends StateNotifier<GalleryModelState> {
  static const int _initialPage = 1;
  static const int _initialResults = 6;

  final Ref ref;

  GalleryViewmodel(this.ref)
      : super(GalleryModelState(
            galleryList: [],
            resultsLoad: _initialResults,
            category: 'flower',
            isLoading: false,
            pageLoad: _initialPage,
            hasMore: false,
            searchQuery: '')) {
    _initialize();
  }

  Future<void> _initialize() async {
    await fetchGalleryList();
  }

  Future<void> fetchGalleryList() async {
    if (state.isLoading || state.hasMore) return;
    try {
      state = state.copyWith(isLoading: true, hasMore: true);
      final galleryData = await ref.read(galleryServiceProvider).getGalleryData(
            searchQuery: state.searchQuery,
            imgType: 'photo',
            results: state.resultsLoad,
            pages: state.pageLoad,
            onError: (error) {
              state = state.copyWith(isLoading: false);
              Utils.toastMessage(error);
            },
            category: state.category,
          );

      if (galleryData.isEmpty) {
        state = state.copyWith(hasMore: false);
      } else {
        state = state.copyWith(
          galleryList: [...state.galleryList, ...galleryData],
          pageLoad: state.pageLoad + 1,
          isLoading: false,
          hasMore: false,
        );
      }
    } on Exception catch (e) {
      Utils.toastMessage(e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> updateCategory(String categ) async {
    state = state.copyWith(
      category: categ,
      galleryList: [],
    );

    await fetchGalleryList();
  }

  Future<void> updateSearchQuery(String query) async {
    state = state.copyWith(
      searchQuery: query,
      galleryList: [],
    );

    await fetchGalleryList();
  }
}
