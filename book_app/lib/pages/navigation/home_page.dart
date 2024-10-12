import 'package:book_app/pages/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:book_app/components/item_card.dart';
import 'package:book_app/global/lists.dart';
import 'package:book_app/pages/add_book_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Переход на страницу добавления новой книги
  void _navigateToAddNote(BuildContext context) async {
    // Ждем возвращения со страницы добавления новой книги
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddBookPage()),
    );

    // Вместе с выходом нам передался result - в нем новая книга
    if (result != null) {
      setState(() {
        items.add(result); // Добавляем новую книгу в список
      });
    }
  }

  // Переход на страницу корзины
  void _navigateToCart(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const CartPage()));
  }

  // Функция для обновения стейта
  void _refreshState() {
    setState(() {});
  }

  void _toggleFavourite(int id) {
    setState(() {
      // items[index].favourite = !items[index].favourite;
      // Тогглим флаг любимого по id книги
      items.map((item) {
        if (item.id == id) item.favourite = !item.favourite;
      }).toList();

      // Обновляем список любимых книг
      favourites = items.where((item) => item.favourite == true).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Главная"),
        actions: [
          IconButton(
            onPressed: () => _navigateToAddNote(context),
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: items.isEmpty
          ? const Center(
              child: Text(
                "В библиотеке пусто 🤷\nПопробуйте добавить книгу",
                style: TextStyle(fontSize: 15),
                textAlign: TextAlign.center,
              ),
            )
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: (MediaQuery.of(context).size.width) /
                    (MediaQuery.of(context).size.height / 1.2),
              ),
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return ItemCard(
                  itemIndex: index,
                  toggleFavourite: _toggleFavourite,
                  itemList: items,
                  refresh: _refreshState,
                );
              }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToCart(context),
        tooltip: 'Добавить книгу',
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }
}
