import 'package:app_1/common/services/storage.dart';
import 'package:app_1/common/utils/environment.dart';
import 'package:app_1/src/orders/hooks/results/fetch_orders_results.dart';
import 'package:app_1/src/orders/models/orders_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;

FetchOrders fetchOrders(String? status) {
  final orders = useState<List<OrdersModel>?>([]);
  final isLoading = useState(false);
  final error = useState<String?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;

    try {
      Uri url = status != null
          ? Uri.parse('${Environment.appBaseUrl}/api/orders/me/?status=$status')
          : Uri.parse('${Environment.appBaseUrl}/api/orders/me/');
      String? accessToken = Storage().getString('accessToken');
      print('Fetching orders with status: $status');

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Token $accessToken',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode == 200) {
        orders.value = ordersModelFromJson(response.body);
        print('Orders fetched: ${orders.value?.length}');
      } else {
        error.value = 'Failed to load orders';
      }
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  useEffect(() {
    fetchData();
    return;
  }, [status]);

  void refetch() {
    //isLoading.value = true;
    fetchData();
  }

  return FetchOrders(
      order: orders.value,
      isLoading: isLoading.value,
      error: error.value,
      refetch: refetch);
}
