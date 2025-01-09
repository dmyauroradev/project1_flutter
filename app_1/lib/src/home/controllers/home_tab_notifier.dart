import 'package:app_1/common/utils/enums.dart';
import 'package:flutter/material.dart';

class HomeTabNotifier with ChangeNotifier {
  QueryType queryType = QueryType.all;
  String _index = 'Tất Cả';

  String get index => _index;

  void setIndex(String index) {
    _index = index;

    switch (index) {
      case 'Tất Cả':
        setQueryType(QueryType.all);
        break;
      case 'Phổ Biến':
        setQueryType(QueryType.popular);
        break;
      case 'Hiện Đại':
        setQueryType(QueryType.modern);
        break;
      case 'Cổ Điển, Vintage':
        setQueryType(QueryType.classic);
        break;
      case 'Tối Giản':
        setQueryType(QueryType.minimalist);
        break;

      default:
        setQueryType(QueryType.all);
    }
    notifyListeners();
  }

  void setQueryType(QueryType q) {
    queryType = q;
    notifyListeners();
  }
}
