import 'package:book_app/components/cart_card.dart';
import 'package:book_app/global/lists.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Корзина'),
        ),
        body: cart.isEmpty
            ? const Center(
                child: Text(
                  "Пусто 🤷\nПопробуйте добавить книгу в корзину",
                  style: TextStyle(fontSize: 15),
                  textAlign: TextAlign.center,
                ),
              )
            : ListView.builder(
                itemCount: cart.length,
                itemBuilder: (BuildContext context, int index) {
                  return CartCard(itemIndex: index);
                },
              ));
  }
}
