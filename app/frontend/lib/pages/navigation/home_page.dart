import 'package:book_app/components/book_list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _refreshState() {}

  @override
  Widget build(BuildContext context) {
    return BookList(
      itemList: 'main',
      refreshState: _refreshState,
    );
  }
}
