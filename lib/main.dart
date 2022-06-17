
import 'package:class08/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'Flutter basic calculator',
      home: Scaffold(
          body: HomePage(),
      ),
    );
  }
}
