import 'package:app_1/common/services/storage.dart';
import 'package:app_1/common/utils/environment.dart';
import 'package:app_1/src/categories/hook/results/category_products_results.dart';
import 'package:app_1/src/products/models/products_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;

FetchProduct fetchWishlist() {
  final products = useState<List<Products>>([]);
  final isLoading = useState(false);
  final error = useState<String?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;

    try {
      Uri url = Uri.parse('${Environment.appBaseUrl}/api/wishlist/me');
      String? accessToken = Storage().getString('accessToken');

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Token $accessToken',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode == 200) {
        products.value = productsFromJson(response.body);
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

  return FetchProduct(
      products: products.value,
      isLoading: isLoading.value,
      error: error.value,
      refetch: refetch);
}
