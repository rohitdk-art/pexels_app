class PexelsImageModel {
  final int id;
  final String photographer;
  final String imageUrl;
  final String largeUrl;

  String get mediumUrl => imageUrl;

  PexelsImageModel({
    required this.id,
    required this.photographer,
    required this.imageUrl,
    required this.largeUrl,
  });

  factory PexelsImageModel.fromJson(Map<String, dynamic> json) {
    return PexelsImageModel(
      id: json['id'],
      photographer: json['photographer'],
      imageUrl: json['src']['medium'],
      largeUrl: json['src']['large2x'],
    );
  }

  factory PexelsImageModel.fromLocalJson(Map<String, dynamic> json) {
    return PexelsImageModel(
      id: json['id'],
      photographer: json['photographer'],
      imageUrl: json['imageUrl'],
      largeUrl: json['largeUrl'],
    );
  }

  Map<String, dynamic> toLocalJson() {
    return {
      'id': id,
      'photographer': photographer,
      'imageUrl': imageUrl,
      'largeUrl': largeUrl,
    };
  }
}
