import 'package:flutter/material.dart';
import 'package:flutter_scraping/screen/search_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartPhone Price Checker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SearchScreen(title: 'SmartPhone Price Checker'),
    );
  }
}
