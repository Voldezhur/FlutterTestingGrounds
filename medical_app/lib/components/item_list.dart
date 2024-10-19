import 'package:flutter/material.dart';
import 'package:medical_app/components/item_card.dart';

class ItemList extends StatefulWidget {
  const ItemList(
      {super.key, required this.itemList, required this.refreshState});

  final List itemList;
  final Function refreshState;

  @override
  State<ItemList> createState() => _BookListState();
}

class _BookListState extends State<ItemList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Главная"),
      ),
      body: widget.itemList.isEmpty
          ? const Center(
              child: Text(
                "Пусто 🤷\nПопробуйте добавить книгу",
                style: TextStyle(fontSize: 15),
                textAlign: TextAlign.center,
              ),
            )
          : ListView.builder(
              itemCount: widget.itemList.length,
              itemBuilder: (BuildContext context, int index) {
                return ItemCard(
                  itemIndex: index,
                  itemList: widget.itemList,
                  refresh: widget.refreshState,
                );
              }),
    );
  }
}
