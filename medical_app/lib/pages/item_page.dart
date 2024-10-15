import 'package:flutter/material.dart';
import 'package:medical_app/global/lists.dart';

class ItemPage extends StatefulWidget {
  const ItemPage({
    super.key,
    required this.itemIndex,
  });

  final int itemIndex;

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  @override
  Widget build(BuildContext context) {
    return widget.itemIndex < items.length
        ? Scaffold(
            appBar: AppBar(
              title: Text(items[widget.itemIndex].title),
              actions: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      Navigator.pop(context, true);
                    });
                  },
                  icon: const Icon(Icons.delete),
                )
              ],
            ),
            body: Center(
              child: Column(
                children: [
                  Image.network(
                    items[widget.itemIndex].imageLink,
                    height: 300,
                  ),
                  Text(
                      "Количество страниц: ${items[widget.itemIndex].pageCount}"),
                  Container(
                    decoration: const BoxDecoration(
                        border:
                            Border(bottom: BorderSide(color: Colors.black26))),
                    padding: const EdgeInsets.only(top: 25),
                    margin: const EdgeInsets.fromLTRB(25, 0, 25, 25),
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Text(items[widget.itemIndex].description))),
                ],
              ),
            ),
          )
        : const Center(
            child: Text(
              "Страница не найдена 🤷",
              style: TextStyle(fontSize: 15),
              textAlign: TextAlign.center,
            ),
          );
  }
}
