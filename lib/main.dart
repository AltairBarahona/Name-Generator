import 'package:flutter/material.dart';
import 'package:startup_namer/pages/practice_page.dart';
import 'package:startup_namer/pages/random_words_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.white), //White colors
      debugShowCheckedModeBanner: false,
      title: "Altair Barahona - Flutter documentation",
      initialRoute: "home",
      routes: {
        "home": (context) => RandomWords(),
        "practice": (context) => PracticePage(),
      },
    );
  }
}
