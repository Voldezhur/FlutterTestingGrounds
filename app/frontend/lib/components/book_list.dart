import 'package:book_app/pages/cart_page.dart';
import 'package:book_app/utilities/api_service.dart';
import 'package:flutter/material.dart';
import 'package:book_app/components/item_card.dart';
// import 'package:book_app/global/lists.dart';
// import 'package:book_app/pages/add_book_page.dart';
import 'package:book_app/models/item.dart';

class BookList extends StatefulWidget {
  const BookList(
      {super.key, required this.itemList, required this.refreshState});

  final List itemList;
  final Function refreshState;

  @override
  State<BookList> createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  late Future<List<Item>> items;

  @override
  void initState() {
    super.initState();
    items = ApiService().getBooks();
  }

  // Переход на страницу добавления новой книги
  void _navigateToAddNote(BuildContext context) async {
    // // Ждем возвращения со страницы добавления новой книги
    // final result = await Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => const AddBookPage()),
    // );

    // // Вместе с выходом нам передался result - в нем новая книга
    // if (result != null) {
    //   setState(() {
    //     items.add(result); // Добавляем новую книгу в список
    //   });
    // }
  }

  // Переход на страницу корзины
  void _navigateToCart(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const CartPage()));
  }

  void _toggleFavourite(int id) {
    // setState(() {
    //   // items[index].favourite = !items[index].favourite;
    //   // Тогглим флаг любимого по id книги
    //   items.map((item) {
    //     if (item.id == id) item.favourite = !item.favourite;
    //   }).toList();

    //   // Обновляем список любимых книг
    //   favourites = items.where((item) => item.favourite == true).toList();
    //   widget.refreshState();
    // });
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
      body: widget.itemList.isEmpty
          ? const Center(
              child: Text(
                "Пусто 🤷\nПопробуйте добавить книгу",
                style: TextStyle(fontSize: 15),
                textAlign: TextAlign.center,
              ),
            )
          : FutureBuilder<List<Item>>(
              future: items,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No products found'));
                }

                final items = snapshot.data!;
                return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: (MediaQuery.of(context).size.width) /
                          (MediaQuery.of(context).size.height / 1.2),
                    ),
                    itemCount: widget.itemList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ItemCard(
                        itemIndex: index,
                        toggleFavourite: _toggleFavourite,
                        itemList: items,
                        refresh: widget.refreshState,
                      );
                    });
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToCart(context),
        tooltip: 'Добавить книгу',
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }
}
