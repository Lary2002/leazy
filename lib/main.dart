import 'package:flutter/material.dart';
import 'pages/questions_page.dart';
import 'pages/welcome_page.dart';
import 'pages/calculator_page.dart';
import 'pages/converter_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes:{
        '/': (context)=> WelcomePage(),
        '/calculator': (context) => CalculatorPage(),
        '/converter': (context) => ConverterPage(),
        '/question': (context) => QuestionsPage()
      } ,
      // home: Calculator(),
    );
  }
}


