import 'package:flutter/material.dart';
import 'core/theme.dart';
import 'screens/home/main_page.dart';

void main() {
  runApp(const BafirokApp());
}

class BafirokApp extends StatelessWidget {
  const BafirokApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bafirok',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const MainPage(), // burada artık bottom bar geliyor
    );
  }
}
