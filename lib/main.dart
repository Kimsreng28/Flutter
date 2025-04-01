import 'package:flutter/material.dart';
import 'package:login_ui/Screens/home.dart';
import 'package:login_ui/Screens/login.dart';
import 'package:login_ui/Screens/register.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login UI',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LogIn(),
        '/register': (context) => const Register(),
        '/home': (context) => const Home(),
      },
    );
  }
}
