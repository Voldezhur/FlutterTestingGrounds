import 'package:book_app/models/cart_item.dart';
import 'package:book_app/models/item.dart';
import 'package:flutter/material.dart';
import 'package:book_app/global/lists.dart';
import 'package:book_app/pages/item_page.dart';

class ItemCard extends StatefulWidget {
  const ItemCard({
    super.key,
    required this.itemIndex,
    required this.toggleFavourite,
    required this.itemList,
    required this.refresh,
  });

  final int itemIndex; // Проп для названия заметки
  final Function toggleFavourite;
  final List itemList;
  final Function refresh;

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  void _goToItemPage(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ItemPage(
              itemIndex: items.indexWhere(
                  (item) => item.id == widget.itemList[widget.itemIndex].id))),
    );

    if (result == true) {
      setState(() {
        items.removeAt(items.indexWhere(
            (item) => item.id == widget.itemList[widget.itemIndex].id));
        // Обновляем список любимых книг
        favourites = items.where((item) => item.favourite == true).toList();
        widget.refresh();
      });
    }
  }

  // Добавить в корзину
  void _addToCart() {
    setState(() {
      Item bookToAdd = items[widget.itemIndex];

      int existingItemIndex = cart.indexWhere((item) => item.item == bookToAdd);

      // Проверяем, есть ли уже книга в корзине
      // Если нет, добавляем новый элемент в список
      if (existingItemIndex == -1) {
        cart.add(CartItem(items[widget.itemIndex], 1));
      }
      // Если есть, прибавляем 1 к количеству
      else {
        cart[existingItemIndex].number++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8),
        // Виджет для того, чтобы весь child стал кликабельным
        child: GestureDetector(
          onTap: () => _goToItemPage(context),
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.2,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              color: Theme.of(context).primaryColor,
            ),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.black12, width: 2))),
                  padding: const EdgeInsets.all(6),
                  width: MediaQuery.sizeOf(context).width / 3,
                  child: Image.network(
                    widget.itemList[widget.itemIndex].imageLink,
                    height: 100,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Кнопка перехода на другую страницу
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Text(
                          widget.itemList[widget.itemIndex].title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                        ),
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Text(
                            widget.itemList[widget.itemIndex].author,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 11),
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Стоимость: ${widget.itemList[widget.itemIndex].price}",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: _addToCart,
                      icon: const Icon(
                        Icons.add_shopping_cart,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        widget.itemList[widget.itemIndex].favourite
                            ? Icons.favorite
                            : Icons.favorite_outline,
                        color: Colors.white,
                      ),
                      onPressed: () => widget.toggleFavourite(
                          widget.itemList[widget.itemIndex].id),
                    ),
                  ],
                )
              ],
            )),
          ),
        ));
  }
}
