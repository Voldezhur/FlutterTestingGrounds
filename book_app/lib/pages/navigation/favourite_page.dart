import 'package:book_app/components/book_list.dart';
import 'package:flutter/material.dart';
import 'package:book_app/global/lists.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  void _refreshState() {}

  @override
  Widget build(BuildContext context) {
    return BookList(
      itemList: favourites,
      refreshState: _refreshState,
    );
  }
}
