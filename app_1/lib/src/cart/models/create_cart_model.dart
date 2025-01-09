// To parse this JSON data, do
//
//     final createCartModel = createCartModelFromJson(jsonString);

import 'dart:convert';

CreateCartModel createCartModelFromJson(String str) =>
    CreateCartModel.fromJson(json.decode(str));

String createCartModelToJson(CreateCartModel data) =>
    json.encode(data.toJson());

/*String createCartModelToJson(CreateCartModel data) {
  try {
    final jsonData = json.encode(data.toJson());
    return utf8.decode(jsonData.codeUnits);
  } catch (e) {
    throw FormatException("Lỗi khi mã hóa dữ liệu JSON: $e");
  }
}*/

class CreateCartModel {
  final int product;
  final int quantity;
  final String dimensions;
  final String code;

  CreateCartModel({
    required this.product,
    required this.quantity,
    required this.dimensions,
    required this.code,
  });

  factory CreateCartModel.fromJson(Map<String, dynamic> json) =>
      CreateCartModel(
        product: json["product"],
        quantity: json["quantity"],
        dimensions: utf8.decode(json["dimensions"].runes.toList()),
        code: utf8.decode(json["code"].runes.toList()),
      );

  Map<String, dynamic> toJson() => {
        "product": product,
        "quantity": quantity,
        "dimensions": dimensions,
        "code": code,
      };
}
