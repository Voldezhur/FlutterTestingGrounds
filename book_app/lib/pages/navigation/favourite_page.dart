import 'package:book_app/pages/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:book_app/components/item_card.dart';
import 'package:book_app/global/lists.dart';
import 'package:book_app/pages/add_book_page.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  void _navigateToAddNote(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddBookPage()),
    );

    if (result != null) {
      setState(() {
        items.add(result);
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

  void _removeItem(int index) {
    setState(() {
      items.removeAt(index);
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Избранное"),
        actions: [
          IconButton(
            onPressed: () => _navigateToAddNote(context),
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: !items.any((item) => item.favourite)
          ? const Center(
              child: Text(
                "Ничего нет в избранном 🤷\nПопробуйте добавить книгу в избранное",
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
              itemCount: favourites.length,
              itemBuilder: (BuildContext context, int index) {
                // return items[index].favourite
                //     ? ItemCard(
                //         itemIndex: index,
                //         toggleFavourite: _toggleFavourite,
                //       )
                //     : const SizedBox.shrink();

                return ItemCard(
                  itemIndex: index,
                  toggleFavourite: _toggleFavourite,
                  itemList: favourites,
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
