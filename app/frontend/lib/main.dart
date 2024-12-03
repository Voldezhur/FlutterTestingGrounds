import 'package:flutter/material.dart';
import 'package:book_app/pages/main_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Убрали надпись Debug
      title: '3D Model Marketplace',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
          surface: const Color.fromARGB(99, 41, 55, 75),
        ),
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}
