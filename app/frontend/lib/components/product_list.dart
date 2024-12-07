import 'package:book_app/components/product_card.dart';
import 'package:book_app/models/product.dart';
import 'package:book_app/pages/add_book_page.dart';
import 'package:book_app/pages/cart_page.dart';
import 'package:book_app/utilities/api_service.dart';
import 'package:book_app/utilities/item_to_json.dart';
import 'package:book_app/utilities/new_api_service.dart';
import 'package:flutter/material.dart';

class ProductList extends StatefulWidget {
  const ProductList(
      {super.key, required this.itemList, required this.refreshState});

  final String itemList;
  final Function refreshState;

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  late Future<List<Product>> products;

  @override
  void initState() {
    super.initState();
    _updateList();
  }

  void _updateList() {
    setState(() {
      switch (widget.itemList) {
        case 'main':
          products = NewApiService().getProducts();
          break;
        // case 'favourites':
        //   products = NewApiService().getFavourites();
        //   break;
        default:
          products = NewApiService().getProducts();
          break;
      }
    });
  }

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
        ApiService().addBook(itemToJson(result));
        _updateList();
      });
    }
  }

  // Переход на страницу корзины
  void _navigateToCart(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const CartPage()));
  }

  @override
  Widget build(BuildContext context) {
    String appBarTitle;

    switch (widget.itemList) {
      case 'main':
        appBarTitle = 'Главная';
        break;
      case 'favourites':
        appBarTitle = 'Избранное';
        break;
      default:
        appBarTitle = 'placeholder';
        break;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        actions: [
          IconButton(
            onPressed: () => _navigateToAddNote(context),
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: FutureBuilder<List<Product>>(
        future: products,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                "Пусто 🤷\n Моделей не найдено",
                style: TextStyle(fontSize: 15),
                textAlign: TextAlign.center,
              ),
            );
          }

          final products = snapshot.data!;

          return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: (MediaQuery.of(context).size.width) /
                    (MediaQuery.of(context).size.height / 1.2),
              ),
              itemCount: products.length,
              itemBuilder: (BuildContext context, int index) {
                return ProductCard(
                  productIndex: index,
                  // toggleFavourite: _toggleFavourite,
                  productList: products,
                  refresh: _updateList,
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToCart(context),
        tooltip: 'Добавить модель',
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }
}
