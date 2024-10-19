import 'package:medical_app/global/lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CartCard extends StatefulWidget {
  const CartCard(
      {super.key,
      required this.itemIndex,
      required this.removeItem,
      required this.incrementItem});

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
      margin: const EdgeInsets.all(16.0),
      child: Slidable(
        startActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              backgroundColor: Theme.of(context).canvasColor,
              icon: Icons.delete,
              label: 'Удалить',
              onPressed: (context) => widget.removeItem(widget.itemIndex),
            )
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            color: Theme.of(context).primaryColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      cart[widget.itemIndex].item.title,
                      style: const TextStyle(
                        color: Colors.white,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        'Стоимость: ${cart[widget.itemIndex].item.price * cart[widget.itemIndex].number}',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () =>
                                widget.incrementItem(widget.itemIndex, true),
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            cart[widget.itemIndex].number.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          IconButton(
                            onPressed: () =>
                                widget.incrementItem(widget.itemIndex, false),
                            icon: const Icon(
                              Icons.remove,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
