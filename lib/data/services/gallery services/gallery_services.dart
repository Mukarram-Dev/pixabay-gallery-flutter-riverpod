import 'package:pixabay_gallery/models/pixabay_model.dart';

abstract class GalleryServices {
  Future<Map<String, dynamic>> sendGetRequest(
    Map<String, String> params,
    Map<String, String> headers,
  );

  Future<List<Hits>> getGalleryData({
    required String searchQuery,
    required String imgType,
    required String category,
    required int results,
    required int pages,
    required Function(String error) onError,
  });
}
