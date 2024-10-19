import 'package:medical_app/components/item_list.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/global/lists.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  void _refreshState() {}

  @override
  Widget build(BuildContext context) {
    return ItemList(
      itemList: favourites,
      refreshState: _refreshState,
    );
  }
}
