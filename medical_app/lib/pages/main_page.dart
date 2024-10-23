import 'package:flutter/material.dart';
import 'package:medical_app/pages/cart_page.dart';
import 'package:medical_app/pages/navigation/home_page.dart';
import 'package:medical_app/pages/navigation/profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedIndex = 0; // Индекс выбранной страницы

  // Список страниц
  static List<Widget> widgetOptions = const <Widget>[
    HomePage(),
    CartPage(),
    ProfilePage()
  ];

  // Переход между страницами
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgetOptions.elementAt(selectedIndex),
      // BottomNavigationBar - параметр параметра body
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/home.png',
              height: 28,
            ),
            label: 'Главная',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Избранное',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профиль',
          ),
        ],
        currentIndex: selectedIndex,
        onTap: onItemTapped,
      ),
    );
  }
}
