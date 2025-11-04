import 'package:flutter/material.dart';
import 'package:jaa_soccer/menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jaa Soccer',
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: Color(0xFF172554),
          secondary: Color(0xFF2563EB),
        ),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}