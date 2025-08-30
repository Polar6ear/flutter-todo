import 'package:flutter/material.dart';
import 'package:todo/pages/home_page.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async{
  runApp( MyApp());
  await Hive.initFlutter();
  //open a box
  var box = await Hive.openBox('mybox');
}
class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _myBox = Hive.box('mybox');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      theme: ThemeData(primarySwatch: Colors.blue)
    );
  }
}