class GalleryModel {
  int total;
  int totalHits;
  List<Hits> hits;

  GalleryModel(
      {required this.total, required this.totalHits, required this.hits});

  factory GalleryModel.fromJson(Map<String, dynamic> json) {
    return GalleryModel(
      total: json['total'] ?? 0, // Provide default value if null
      totalHits: json['totalHits'] ?? 0, // Provide default value if null
      hits: (json['hits'] as List<dynamic>?)
              ?.map((v) => Hits.fromJson(v))
              .toList() ??
          [], // Handle null safely
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['totalHits'] = totalHits;
    data['hits'] = hits.map((v) => v.toJson()).toList();
    return data;
  }
}

class Hits {
  int? id;
  String? pageURL;
  String? previewURL;
  int? previewWidth;
  int? previewHeight;
  String? webformatURL;
  int? webformatWidth;
  int? webformatHeight;
  String? largeImageURL;
  int? views;
  int? likes;
  int? comments;
  String? userImageURL;

  Hits(
      {this.id,
      this.pageURL,
      this.previewURL,
      this.previewWidth,
      this.previewHeight,
      this.webformatURL,
      this.webformatWidth,
      this.webformatHeight,
      this.largeImageURL,
      this.views,
      this.likes,
      this.comments,
      this.userImageURL});

  factory Hits.fromJson(Map<String, dynamic> json) {
    return Hits(
      id: json['id'],
      pageURL: json['pageURL'],
      previewURL: json['previewURL'],
      previewWidth: json['previewWidth'],
      previewHeight: json['previewHeight'],
      webformatURL: json['webformatURL'],
      webformatWidth: json['webformatWidth'],
      webformatHeight: json['webformatHeight'],
      largeImageURL: json['largeImageURL'],
      views: json['views'],
      likes: json['likes'],
      comments: json['comments'],
      userImageURL: json['userImageURL'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['pageURL'] = pageURL;
    data['previewURL'] = previewURL;
    data['previewWidth'] = previewWidth;
    data['previewHeight'] = previewHeight;
    data['webformatURL'] = webformatURL;
    data['webformatWidth'] = webformatWidth;
    data['webformatHeight'] = webformatHeight;
    data['largeImageURL'] = largeImageURL;
    data['views'] = views;
    data['likes'] = likes;
    data['comments'] = comments;
    data['userImageURL'] = userImageURL;
    return data;
  }
}
