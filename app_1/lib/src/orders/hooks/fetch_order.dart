import 'package:app_1/common/services/storage.dart';
import 'package:app_1/common/utils/environment.dart';
import 'package:app_1/src/orders/hooks/results/fetch_order_results.dart';
import 'package:app_1/src/orders/models/orders_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;

FetchOrder fetchOrder(int id) {
  final order = useState<OrdersModel?>(null);
  final isLoading = useState(false);
  final error = useState<String?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;

    try {
      Uri url =
          Uri.parse('${Environment.appBaseUrl}/api/orders/single/?id=$id');
      String? accessToken = Storage().getString('accessToken');

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Token $accessToken',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode == 200) {
        order.value = ordersModelSingleFromJson(response.body);
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
  }, const []);

  void refetch() {
    isLoading.value = true;
    fetchData();
  }

  return FetchOrder(
      order: order.value,
      isLoading: isLoading.value,
      error: error.value,
      refetch: refetch);
}
