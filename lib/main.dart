import 'package:flutter/material.dart';
import 'package:jaa_soccer/screens/menu.dart';

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
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(width: 1.0, color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(width: 1.0, color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              width: 4.0,
              color: Color(0xFF2563EB),
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
          ),
          labelStyle: const TextStyle(color: Color(0xFF172554)),
          errorStyle: const TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
          floatingLabelStyle: WidgetStateTextStyle.resolveWith((states) {
            if (states.contains(WidgetState.error)) {
              return const TextStyle(color: Colors.red);
            }
            if (states.contains(WidgetState.focused)) {
              return const TextStyle(color: Color(0xFF172554));
            }
            return const TextStyle(color: Color(0xFF172554));
          }),
        )
      ),
      home: MyHomePage(),
    );
  }
}