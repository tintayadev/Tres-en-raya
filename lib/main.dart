import 'package:flutter/material.dart';
import 'package:new_project/src/homePage.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text("Tres en raya by Paulo ;D"),
        ),
        body: HomePage(),
        )
    );
  }
}
