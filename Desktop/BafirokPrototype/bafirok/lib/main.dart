import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme.dart';
import 'screens/home/main_page.dart';
import 'providers/comment_provider.dart';

void main() {
  runApp(const BafirokApp());
}

class BafirokApp extends StatelessWidget {
  const BafirokApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CommentProvider()),
      ],
      child: MaterialApp(
        title: 'Bafirok',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        home: const MainPage(),
      ),
    );
  }
}
