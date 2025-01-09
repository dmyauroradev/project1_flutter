import 'dart:convert';

List<AddressModel> addressListFromJson(String str) => List<AddressModel>.from(
    json.decode(str).map((x) => AddressModel.fromJson(x)));

AddressModel addressModelFromJson(String str) =>
    AddressModel.fromJson(json.decode(str));

class AddressModel {
  final int id;
  final double lat;
  final double lng;
  final bool isDefault;
  final String address;
  final String phone;
  final String addressType;
  final int userId;

  AddressModel({
    required this.id,
    required this.lat,
    required this.lng,
    required this.isDefault,
    required this.address,
    required this.phone,
    required this.addressType,
    required this.userId,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        id: json["id"],
        lat: json["lat"]?.toDouble(),
        lng: json["lng"]?.toDouble(),
        isDefault: json["isDefault"],
        address: utf8.decode(json["address"].runes.toList()),
        phone: json["phone"],
        addressType: utf8.decode(json["addressType"].runes.toList()),
        userId: json["userId"],
      );

  /*Map<String, dynamic> toJson() => {
        "id": id,
        "lat": lat,
        "lng": lng,
        "isDefault": isDefault,
        "address": address,
        "phone": phone,
        "addressType": addressType,
        "userId": userId,
      };*/
}
