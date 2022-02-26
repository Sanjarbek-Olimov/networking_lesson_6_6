import 'package:flutter/material.dart';
import 'package:networking_lesson_6_6/pages/details_page.dart';
import 'package:networking_lesson_6_6/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      routes: {
        HomePage.id: (context) => const HomePage(),
        DetailsPage.id: (context) => DetailsPage()
      },
    );
  }
}
