import 'package:book_app/models/item.dart';
import 'package:dio/dio.dart';

class ApiService {
  final Dio dio = Dio();

  // Получить список всех книг
  // Возвращает список объектов класса Item
  Future<List<Item>> getBooks() async {
    try {
      final response = await dio.get('http://10.0.2.2:8080/products');
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

  Future<List<Item>> getFavourites() async {
    try {
      final response = await dio.get('http://10.0.2.2:8080/products');
      if (response.statusCode == 200) {
        // Переводим полученный JSON в список книг
        List<Item> items =
            (response.data as List).map((item) => Item.fromJson(item)).toList();
        // Выделяем из полученного списка только любимые
        final favourites = items.where((x) => x.favourite).toList();
        return favourites;
      } else {
        throw Exception('Failed to load items');
      }
    } catch (e) {
      throw Exception('Error fetching items: $e');
    }
  }

  // Получить книгу по ID
  // Возвращает объект класса Item
  Future<Item> getBookById(id) async {
    try {
      final response = await dio.get('http://10.0.2.2:8080/products/$id');
      if (response.statusCode == 200) {
        Item item = Item.fromJson(response.data);
        return item;
      } else {
        throw Exception('Failed to load item');
      }
    } catch (e) {
      throw Exception('Error fetching item: $e');
    }
  }

  // Удалить книгу по ID
  // На вход получает ID книги
  void deleteBookById(id) async {
    try {
      final response =
          await dio.delete('http://10.0.2.2:8080/products/delete/$id');
      if (response.statusCode != 204) {
        throw Exception(
            'Failed to delete item $id, status code ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('could not delete item: $e');
    }
  }

  // Редактировать книгу по ID
  // Получает на вход ID книги и JSON объект, подогнанный под формат для бекенда
  void updateBookById(id, newItem) async {
    try {
      final response = await dio.put(
        'http://10.0.2.2:8080/products/update/$id',
        data: newItem,
      );
      if (response.statusCode != 200) {
        throw Exception(
            'Failed to update item $id, status code ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('could not update item: $e');
    }
  }
}
