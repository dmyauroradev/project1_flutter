import 'dart:convert';

List<Products> productsFromJson(String str) =>
    List<Products>.from(json.decode(str).map((x) => Products.fromJson(x)));
String productsToJson(List<Products> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Products {
  final int id;
  final String title;
  final int price;
  final String description;
  final bool isFeatured;
  final String decorationType;
  final double ratings;
  final List<String> code;
  final List<String> imageUrls;
  final List<String> dimensions;
  final DateTime createdAt;
  final int category;
  final int stockQuantity;
  //final String brand;
  //final double ecoFriendlyLevel;
  //final String material;
  //final String style;
  //final String applications;
  //final String url;

  Products({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.isFeatured,
    required this.decorationType,
    required this.ratings,
    required this.code,
    required this.imageUrls,
    required this.dimensions,
    required this.createdAt,
    required this.category,
    required this.stockQuantity,
    //required this.brand,
    //required this.ecoFriendlyLevel,
    //required this.material,
    //required this.style,
    //required this.applications,
    //required this.url,
  });

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        id: json["id"] ?? 0,
        title: utf8.decode(json["title"].runes.toList()),
        price: json['price'] is int ? json['price'] : int.parse(json["price"]),
        description: utf8.decode(json["description"].runes.toList()),
        isFeatured: json["isFeatured"] ?? false,
        decorationType: utf8.decode(json["decorationType"].runes.toList()),
        ratings: json["ratings"] ?? 0.0,
        code: List<String>.from(
            json["code"].map((x) => utf8.decode(x.toString().codeUnits))),
        imageUrls: List<String>.from(json["imageUrls"].map((x) => x)),
        dimensions: List<String>.from(
            json["dimensions"].map((x) => utf8.decode(x.toString().codeUnits))),
        createdAt: DateTime.parse(json["created_at"]),
        category: json["category"] ?? 0,
        stockQuantity: json["stockQuantity"] ?? 0,
        //brand: utf8.decode(json["brand"].runes.toList()),
        //ecoFriendlyLevel: json["ecoFriendlyLevel"] ?? 0.0,
        //material: json["material"] ?? "",
        //style: json["style"] ?? "",
        //applications: utf8.decode(json["applications"].runes.toList()),
        //url: json['url'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "description": description,
        "is_featured": isFeatured,
        "decorationType": decorationType,
        "ratings": ratings,
        "code": List<dynamic>.from(code.map((x) => x)),
        "imageUrls": List<dynamic>.from(imageUrls.map((x) => x)),
        "dimensions": List<dynamic>.from(dimensions.map((x) => x)),
        "created_at": createdAt.toIso8601String(),
        "category": category,
        "stock_quantity": stockQuantity,
        //"brand": brand,
        //"ecoFriendlyLevel": ecoFriendlyLevel,
        //"material": material,
        //"style": style,
        //"applications": applications,
        //"url": url,
      };
}
