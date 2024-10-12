import 'package:book_app/global/lists.dart';
import 'package:flutter/material.dart';

class CartCard extends StatefulWidget {
  const CartCard({super.key, required this.itemIndex});

  final int itemIndex;

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        color: Theme.of(context).primaryColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Row(
            children: [
              Text(cart[widget.itemIndex].item.title),
              Text(cart[widget.itemIndex].number.toString()),
            ],
          ),
        ),
      ),
    );
  }
}
