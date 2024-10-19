import 'package:medical_app/components/cart_card.dart';
import 'package:medical_app/global/lists.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  void _removeItem(int index) {
    setState(() {
      cart.removeAt(index);
    });
  }

  void _incrementItem(int index, bool add) {
    setState(() {
      if (add) {
        cart[index].number++;
      } else {
        cart[index].number--;
      }

      if (cart[index].number == 0) {
        cart.removeAt(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Корзина'),
        ),
        body: cart.isEmpty
            ? const Center(
                child: Text(
                  "Пусто 🤷\nПопробуйте добавить услугу в корзину",
                  style: TextStyle(fontSize: 15),
                  textAlign: TextAlign.center,
                ),
              )
            : Expanded(
                child: Stack(
                  children: [
                    ListView.builder(
                      itemCount: cart.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CartCard(
                          itemIndex: index,
                          removeItem: _removeItem,
                          incrementItem: _incrementItem,
                        );
                      },
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          color: Theme.of(context).disabledColor,
                        ),
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Суммарная стоимость корзины: ${cart.fold(0, (sum, book) => sum + (book.item.price * book.number))}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ));
  }
}
