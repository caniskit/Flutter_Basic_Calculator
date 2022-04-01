import 'package:basic_calc_app/pages/calculator_page.dart';
import 'package:basic_calc_app/pages/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       primarySwatch: Colors.amber,
       textTheme: const TextTheme(bodyText1: TextStyle(fontSize: 26)),
       
       
      ),
      home: dCalculatorHome(),
    );
  }
}
