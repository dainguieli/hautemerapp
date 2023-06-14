
import 'package:flutter/material.dart';
import 'package:hautemerapp/splashScreen/splash_screen.dart';
import 'package:hautemerapp/test.dart';
Future <void>  main() async {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Haute Mer App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:   const MySplashScreen(),

    );
  }
}


