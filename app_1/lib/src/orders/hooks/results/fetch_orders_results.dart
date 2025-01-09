import 'package:app_1/src/orders/models/orders_model.dart';

class FetchOrders {
  final List<OrdersModel>? order;
  final bool isLoading;
  final String? error;
  final void Function() refetch;

  FetchOrders({
    required this.order,
    required this.isLoading,
    required this.error,
    required this.refetch,
  });
}
