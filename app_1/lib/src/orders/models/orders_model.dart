import 'dart:convert';

List<OrdersModel> ordersModelFromJson(String str) => List<OrdersModel>.from(
    json.decode(str).map((x) => OrdersModel.fromJson(x)));

OrdersModel ordersModelSingleFromJson(String str) =>
    OrdersModel.fromJson(json.decode(str));

String ordersModelToJson(List<OrdersModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrdersModel {
  final int id;
  final String customerId;
  final List<OrderProduct> orderProducts;
  final List<int> rated;
  final int totalQuantity;
  final int subtotal;
  final int total;
  final String deliveryStatus;
  final String paymentStatus;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int user;
  final int address;

  OrdersModel({
    required this.id,
    required this.customerId,
    required this.orderProducts,
    required this.rated,
    required this.totalQuantity,
    required this.subtotal,
    required this.total,
    required this.deliveryStatus,
    required this.paymentStatus,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.address,
  });

  @override
  String toString() {
    return 'OrdersModel(id: $id, total: $total, status: $deliveryStatus)';
  }

  factory OrdersModel.fromJson(Map<String, dynamic> json) => OrdersModel(
        id: json["id"],
        customerId: json["customer_id"],
        orderProducts: List<OrderProduct>.from(
            json["order_products"].map((x) => OrderProduct.fromJson(x))),
        rated: List<int>.from(json["rated"].map((x) => x)),
        totalQuantity: json["total_quantity"],
        subtotal: json["subtotal"],
        total: json["total"],
        deliveryStatus: utf8.decode(json["delivery_status"].runes.toList()),
        paymentStatus: utf8.decode(json["payment_status"].runes.toList()),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        user: json["user"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer_id": customerId,
        "order_products":
            List<dynamic>.from(orderProducts.map((x) => x.toJson())),
        "rated": List<dynamic>.from(rated.map((x) => x)),
        "total_quantity": totalQuantity,
        "subtotal": subtotal,
        "total": total,
        "delivery_status": deliveryStatus,
        "payment_status": paymentStatus,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user": user,
        "address": address,
      };
}

class OrderProduct {
  final int productId;
  final String imageUrl;
  final String title;
  final int price;
  final int quantity;
  final String dimensions;
  final String code;

  OrderProduct({
    required this.productId,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.quantity,
    required this.dimensions,
    required this.code,
  });

  factory OrderProduct.fromJson(Map<String, dynamic> json) => OrderProduct(
        productId: json["product_id"],
        imageUrl: json["imageUrl"],
        title: utf8.decode(json["title"].runes.toList()),
        price: json["price"],
        quantity: json["quantity"],
        dimensions: utf8.decode(json["dimensions"].runes.toList()),
        code: utf8.decode(json["code"].runes.toList()),
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "imageUrl": imageUrl,
        "title": title,
        "price": price,
        "quantity": quantity,
        "dimensions": dimensions,
        "code": code,
      };
}
