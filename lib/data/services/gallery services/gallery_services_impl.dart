import 'dart:async';
import 'dart:convert' show jsonDecode;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:pixabay_gallery/const/api_points.dart';
import 'package:pixabay_gallery/data/services/gallery%20services/gallery_services.dart';
import 'package:pixabay_gallery/models/pixabay_model.dart';

final galleryServiceProvider = Provider(
  (ref) => GalleryServicesImpl(),
);

class GalleryServicesImpl implements GalleryServices {
  GalleryServicesImpl._getPrivateConstructor();

  static final GalleryServicesImpl _instance =
      GalleryServicesImpl._getPrivateConstructor();

  factory GalleryServicesImpl() => _instance;

  @override
  Future<Map<String, dynamic>> sendGetRequest(
    Map<String, String> params,
    Map<String, String> headers,
  ) async {
    try {
      // Constructing the URI with proper query parameters
      final uri = Uri.https('pixabay.com', '/api/', params);

      final response = await http
          .get(
            uri,
            headers: headers,
          )
          .timeout(const Duration(minutes: 1));

      return {'status': response.statusCode, 'body': response.body};
    } on http.ClientException catch (e) {
      return {'status': -1, 'body': 'ClientException: ${e.message}'};
    } on TimeoutException catch (e) {
      return {'status': -1, 'body': 'TimeoutException: ${e.message}'};
    } catch (e) {
      return {'status': -1, 'body': 'Exception: ${e.toString()}'};
    }
  }

  @override
  Future<List<Hits>> getGalleryData({
    required String searchQuery,
    required String category,
    required String imgType,
    required int results,
    required int? pages,
    required Function(String error) onError,
  }) async {
    try {
      // Building the query parameters
      final queryParams = {
        'key': pixabayKey,
        'q': searchQuery,
        'category': category,
        'image_type': imgType, // Default to 'photo'
        'per_page': results.toString(), // Default to 10 results
        'page': pages?.toString() ?? '1', // Default to page 1
        'pretty': 'true', // Optional: for pretty-printed JSON response
      };

      // Sending the GET request
      final response = await sendGetRequest(queryParams, {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      });

      final status = response['status'];
      final body = response['body'];

      // Check for successful response
      if (status == 200) {
        // Parse JSON response body
        final Map<String, dynamic> jsonData = jsonDecode(body);
        print(jsonData);
        final List<Hits> galleryList = (jsonData['hits'] as List<dynamic>)
            .map((item) => Hits.fromJson(item))
            .toList();

        // Call onSuccess with parsed hits
        return galleryList;
      } else {
        onError('Error: $body');
        return [];
      }
    } catch (e) {
      // Handling exceptions
      onError('Exception: ${e.toString()}');
      return [];
    }
  }
}
