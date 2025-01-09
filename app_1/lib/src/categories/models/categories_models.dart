import 'dart:convert';

List<Categories> categoriesFromJson(String str) =>
    List<Categories>.from(json.decode(str).map(
          (x) => Categories.fromJson(x),
        ));

String categoriesToJson(List<Categories> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Categories {
  final String title;
  final int id;
  final String imageUrl;

  Categories({
    required this.title,
    required this.id,
    required this.imageUrl,
  });

  @override
  String toString() {
    return 'Categories(title: $title, id: $id, imageUrl: $imageUrl)';
  }

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
      title: json["title"] ?? 'Unknown',
      id: json["id"],
      imageUrl: json["imageUrl"] ?? '');

  Map<String, dynamic> toJson() => {
        "title": title,
        "id": id,
        "imageUrl": imageUrl,
      };
}
