import 'package:book_app/models/item.dart';
import 'package:dio/dio.dart';

class ApiService {
  final Dio dio = Dio();
  Future<List<Item>> getBooks() async {
    try {
      final response = await dio.get('http://localhost:8080/products');
      if (response.statusCode == 200) {
        // Переводим полученный JSON в список книг
        List<Item> items =
            (response.data as List).map((item) => Item.fromJson(item)).toList();
        return items;
      } else {
        throw Exception('Failed to load items');
      }
    } catch (e) {
      throw Exception('Error fetching items: $e');
    }
  }
}
