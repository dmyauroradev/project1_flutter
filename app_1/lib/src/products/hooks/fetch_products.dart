import 'package:app_1/common/utils/enums.dart';
import 'package:app_1/common/utils/environment.dart';
import 'package:app_1/src/categories/hook/results/category_products_results.dart';
import 'package:app_1/src/products/models/products_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;

FetchProduct fetchProducts(QueryType queryType) {
  final products = useState<List<Products>>([]);
  final isLoading = useState(false);
  final error = useState<String?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;
    Uri url;

    try {
      switch (queryType) {
        case QueryType.all:
          url = Uri.parse('${Environment.appBaseUrl}/api/products/');
          break;
        case QueryType.popular:
          url = Uri.parse('${Environment.appBaseUrl}/api/products/popular');
          break;
        case QueryType.modern:
          url = Uri.parse(
              '${Environment.appBaseUrl}/api/products/byType/?decorationType=${queryType.name}');
          break;
        case QueryType.classic:
          url = Uri.parse(
              '${Environment.appBaseUrl}/api/products/byType/?decorationType=${queryType.name}');
          break;
        case QueryType.minimalist:
          url = Uri.parse(
              '${Environment.appBaseUrl}/api/products/byType/?decorationType=${queryType.name}');
          break;
      }

      final response = await http.get(url);

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
  }, [queryType.index]);

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
