import 'package:medical_app/global/lists.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class CartCard extends StatefulWidget {
  const CartCard({
    super.key,
    required this.itemIndex,
    required this.removeItem,
    required this.incrementItem,
  });

  final int itemIndex;
  final Function removeItem;
  final Function incrementItem;

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 136,
      margin: const EdgeInsets.fromLTRB(27.5, 0, 27.5, 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        border: Border.all(
          color: const Color.fromRGBO(224, 224, 224, 100),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Text(
                  cart[widget.itemIndex].item.title,
                  style: const TextStyle(fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              Transform.rotate(
                  angle: 45 * math.pi / 180,
                  child: IconButton(
                      onPressed: () {}, icon: const Icon(Icons.add))),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${cart[widget.itemIndex].item.price} ₽',
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
              Container(
                width: 96,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: Theme.of(context).primaryColor,
                ),
                child: const Center(
                  child: Text(
                    'Добавить',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
