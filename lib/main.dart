import 'package:flutter/material.dart';
import 'package:quick_note/screen/get_start_screen.dart';
import 'package:quick_note/screen/landing_screen.dart';
import 'package:quick_note/screen/quick_note_screen.dart';
import 'package:quick_note/screen/sign_up_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Route _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          ),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QuickNote',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return _createRoute(const GetStartScreen());
          case '/landing':
            return _createRoute(const LandingScreen());
          case '/signUp':
            return _createRoute(const SignUpScreen());
          case '/quiz':
            return _createRoute(const QuickNoteScreen());
          default:
            return null;
        }
      },
    );
  }
}
