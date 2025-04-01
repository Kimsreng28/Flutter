import 'package:flutter/material.dart';
import 'package:login_ui/Components/custom_button.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                'Hello HAIKIMSRENG, Welcome!',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Lato"),
              ),
            ),
            const SizedBox(height: 20),
            // buttons logout
            CustomButton(
              text: 'Logout',
              color: const Color(0xFFfc344c),
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
