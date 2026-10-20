import 'package:flutter/material.dart';

import 'screens/onboarding/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const StockCoApp(),
  );
}

class StockCoApp extends StatelessWidget {
  const StockCoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'stock.co',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Arial',
      ),
      home: const SplashScreen(),
    );
  }
}