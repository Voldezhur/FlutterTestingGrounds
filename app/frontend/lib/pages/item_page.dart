import 'package:book_app/models/item.dart';
import 'package:book_app/utilities/api_service.dart';
import 'package:flutter/material.dart';

class ItemPage extends StatefulWidget {
  const ItemPage({
    super.key,
    required this.itemID,
  });

  final int itemID;

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  late Future<Item> item;

  @override
  void initState() {
    super.initState();
    item = ApiService().getBookById(widget.itemID);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: item,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return const Center(child: Text('No such book'));
        }

        final item = snapshot.data!;

        return Scaffold(
          appBar: AppBar(
            title: Text(item.title),
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
                  item.imageLink,
                  height: 300,
                ),
                Text("Количество страниц: ${item.pageCount}"),
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
                        child: Text(item.description))),
              ],
            ),
          ),
        );
      },
    );
  }
}
