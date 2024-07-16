import 'package:flutter/material.dart';
import 'package:pokemon_api_app/Constants/Appbar.dart';
import 'package:pokemon_api_app/Screen/HomeScreen/home_screen.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Flutter Demo',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen());
  }
}
