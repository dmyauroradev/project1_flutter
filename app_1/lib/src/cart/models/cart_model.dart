// To parse this JSON data, do
//
//     final cartModel = cartModelFromJson(jsonString);

import 'dart:convert';

List<CartModel> cartModelFromJson(String str) =>
    List<CartModel>.from(json.decode(str).map((x) => CartModel.fromJson(x)));

String cartModelToJson(List<CartModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CartModel {
  final int id;
  final Product product;
  final int quantity;
  final String dimensions;
  final String code;

  CartModel({
    required this.id,
    required this.product,
    required this.quantity,
    required this.dimensions,
    required this.code,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        id: json["id"],
        product: Product.fromJson(json["product"]),
        quantity: json["quantity"],
        dimensions: utf8.decode(json["dimensions"].runes.toList()),
        code: utf8.decode(json["code"].runes.toList()),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product": product.toJson(),
        "quantity": quantity,
        "dimensions": dimensions,
        "code": code,
      };
}

class Product {
  final int id;
  final String title;
  final int price;
  final String description;
  final bool isFeatured;
  final String decorationType;
  final double ratings;
  //final String brand;
  //final String material;
  //final int ecoFriendlyLevel;
  final List<String> code;
  final List<String> dimensions;
  //final String applications;
  //final String style;
  final List<String> imageUrls;
  final int stockQuantity;
  final DateTime createdAt;
  final int category;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.isFeatured,
    required this.decorationType,
    required this.ratings,
    //required this.brand,
    //required this.material,
    //required this.ecoFriendlyLevel,
    required this.code,
    required this.dimensions,
    //required this.applications,
    //required this.style,
    required this.imageUrls,
    required this.stockQuantity,
    required this.createdAt,
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: utf8.decode(json["title"].runes.toList()),
        price: json['price'] is int ? json['price'] : int.parse(json["price"]),
        //price: json["price"],
        description: utf8.decode(json["description"].runes.toList()),
        isFeatured: json["is_featured"],
        decorationType: utf8.decode(json["decorationType"].runes.toList()),
        ratings: json["ratings"]?.toDouble(),
        //brand: utf8.decode(json["brand"].runes.toList()),
        //material: json["material"],
        //ecoFriendlyLevel: json["ecoFriendlyLevel"],
        code: List<String>.from(
            json["code"].map((x) => utf8.decode(x.toString().codeUnits))),
        dimensions: List<String>.from(
            json["dimensions"].map((x) => utf8.decode(x.toString().codeUnits))),
        //applications: utf8.decode(json["applications"].runes.toList()),
        //style: json["style"],
        imageUrls: List<String>.from(json["imageUrls"].map((x) => x)),
        stockQuantity: json["stock_quantity"],
        createdAt: DateTime.parse(json["created_at"]),
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "description": description,
        "is_featured": isFeatured,
        "decorationType": decorationType,
        "ratings": ratings,
        //"brand": brand,
        //"material": material,
        //"ecoFriendlyLevel": ecoFriendlyLevel,
        "code": List<dynamic>.from(code.map((x) => x)),
        "dimensions": List<dynamic>.from(dimensions.map((x) => x)),
        //"applications": applications,
        //"style": style,
        "imageUrls": List<dynamic>.from(imageUrls.map((x) => x)),
        "stock_quantity": stockQuantity,
        "created_at": createdAt.toIso8601String(),
        "category": category,
      };
}
