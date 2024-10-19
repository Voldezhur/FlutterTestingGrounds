import 'package:medical_app/models/cart_item.dart';
import 'package:medical_app/models/item.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/global/lists.dart';

class ItemCard extends StatefulWidget {
  const ItemCard({
    super.key,
    required this.itemIndex,
    required this.itemList,
    required this.refresh,
  });

  final int itemIndex; // Проп для названия заметки
  final List itemList;
  final Function refresh;

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
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
    return Container(
      height: MediaQuery.of(context).size.height * 0.1635,
      margin: const EdgeInsets.fromLTRB(27.5, 0, 27.5, 16),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: Border.all(
          color: const Color.fromRGBO(224, 224, 224, 100),
        ),
      ),
      child: Row(
        children: [
          Text(items[widget.itemIndex].title),
        ],
      ),
    );
  }
}
