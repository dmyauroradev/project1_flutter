import 'dart:convert';

CreateCheckout createCheckoutFromJson(String str) =>
    CreateCheckout.fromJson(json.decode(str));

String createCheckoutToJson(CreateCheckout data) =>
    json.encode((data.toJson()));

class CreateCheckout {
  final String accesstoken;
  final String fcm;

  final int totalAmount;
  final List<CartItem> cartItems;
  final int address;

  CreateCheckout({
    required this.address,
    required this.accesstoken,
    required this.fcm,
    required this.totalAmount,
    required this.cartItems,
  });

  factory CreateCheckout.fromJson(Map<String, dynamic> json) => CreateCheckout(
        address: json["address"],
        accesstoken: json["accesstoken"],
        fcm: json["fcm"],
        totalAmount: json["totalAmount"],
        cartItems: List<CartItem>.from(
            json["cartItems"].map((x) => CartItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "accesstoken": accesstoken,
        "fcm": fcm,
        "totalAmount": totalAmount,
        "cartItems": List<dynamic>.from(cartItems.map((x) => x.toJson())),
      };
}

class CartItem {
  final String name;
  final String dimensions;
  final String code;
  final int id;
  final int price;
  final int cartQuantity;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.cartQuantity,
    required this.code,
    required this.dimensions,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
      id: json["id"],
      name: utf8.decode(json["name"].runes.toList()),
      price: json['price'] is int ? json['price'] : int.parse(json["price"]),
      //price: json["price"],
      cartQuantity: json["cartQuantity"],
      code: utf8.decode(json["code"].runes.toList()),
      dimensions: utf8.decode(json["dimensions"].runes.toList()));

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "cartQuantity": cartQuantity,
        "code": code,
        "dimensions": dimensions,
      };
}
