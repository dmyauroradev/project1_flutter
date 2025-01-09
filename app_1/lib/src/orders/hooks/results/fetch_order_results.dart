import 'package:app_1/src/orders/models/orders_model.dart';
import 'package:flutter/material.dart';

class FetchOrder {
  final OrdersModel? order;
  final bool isLoading;
  final String? error;
  final VoidCallback refetch;

  FetchOrder(
      {required this.order,
      required this.isLoading,
      required this.error,
      required this.refetch});
}
