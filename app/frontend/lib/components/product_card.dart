import 'package:book_app/models/product.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    super.key,
    required this.productIndex,
    // required this.toggleFavourite,
    required this.productList,
    required this.refresh,
  });

  final int productIndex; // Проп для названия заметки
  // final Function toggleFavourite;
  final List<Product> productList;
  final Function refresh;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  // void _goToItemPage(BuildContext context) async {
  //   final result = await Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => ItemPage(
  //           itemID:
  //               widget.productList[widget.productIndex].id), // Подаем id книги
  //     ),
  //   );

  //   if (result == true) {
  //     setState(() {
  //       ApiService().deleteBookById(widget.productList[widget.productIndex]
  //           .id); // Удаляем книгу по id, если на странице книги нажали на мусорку
  //       widget.refresh();
  //     });
  //   }
  // }

  // // Добавить в корзину
  // void _addToCart() {
  //   setState(() {
  //     Item bookToAdd = items[widget.productIndex];

  //     int existingItemIndex = cart.indexWhere((item) => item.item == bookToAdd);

  //     // Проверяем, есть ли уже книга в корзине
  //     // Если нет, добавляем новый элемент в список
  //     if (existingItemIndex == -1) {
  //       cart.add(CartItem(items[widget.productIndex], 1));
  //     }
  //     // Если есть, прибавляем 1 к количеству
  //     else {
  //       cart[existingItemIndex].number++;
  //     }
  //   });
  // }

  // void _toggleFavourite() {
  //   setState(() {
  //     Item item = widget.productList[widget.productIndex];
  //     Object newItem = itemToJson(item, favourite: !item.favourite);

  //     ApiService().updateBookById(
  //       widget.productList[widget.productIndex].id,
  //       newItem,
  //     );

  //     widget.refresh();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      // Виджет для того, чтобы весь child стал кликабельным
      child: GestureDetector(
        onTap: () {},
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
                  widget.productList[widget.productIndex].imageUrl,
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
                        widget.productList[widget.productIndex].name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Text(
                          widget.productList[widget.productIndex].creatorId
                              .toString(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 11),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Стоимость: ${widget.productList[widget.productIndex].price}",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.add_shopping_cart,
                      color: Colors.white,
                    ),
                  ),
                  // IconButton(
                  //   icon: Icon(
                  //     widget.productList[widget.productIndex].favourite
                  //         ? Icons.favorite
                  //         : Icons.favorite_outline,
                  //     color: Colors.white,
                  //   ),
                  //   onPressed: () => _toggleFavourite(),
                  // ),
                ],
              )
            ],
          )),
        ),
      ),
    );
  }
}
