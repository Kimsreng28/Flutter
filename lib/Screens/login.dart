import 'package:flutter/material.dart';
import 'package:login_ui/Components/custom_button.dart';
import 'package:login_ui/Components/custom_textfield.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  bool isRememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 70),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Login to your \naccount',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Lato",
                ),
              ),
              Image.asset(
                'assets/images/accent.png',
                height: 100,
                width: 200,
              ),
              const SizedBox(height: 10),
              const Center(
                  child:
                      CustomTextfield(hintText: 'Email', obscureText: false)),
              const Center(
                  child:
                      CustomTextfield(hintText: 'Password', obscureText: true)),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  children: [
                    Checkbox(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      value: isRememberMe,
                      onChanged: (value) {
                        setState(() {
                          isRememberMe = value!;
                        });
                      },
                    ),
                    const Text(
                      'Remember me',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: "Lato",
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Center(
                child: CustomButton(
                  text: 'Login',
                  color: const Color(0xFF2c74fb),
                  onPressed: () {
                    Navigator.pushNamed(context, '/home');
                  },
                  style: const TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 16,
                    fontFamily: "Lato",
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Center(
                child: Text(
                  'Or',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: "Lato",
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Center(
                child: CustomButton(
                  iconPath: 'assets/icons/icons8-google.svg',
                  text: 'Login with Google',
                  color: const Color.fromARGB(255, 255, 255, 255),
                  onPressed: () {},
                  style: const TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 16,
                    fontFamily: "Lato",
                  ),
                ),
              ),
              const SizedBox(height: 100),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Don\'t have an account?',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: "Lato",
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/register'),
                    child: const Text(
                      'Register',
                      style: TextStyle(
                        color: Color(0xFF2c74fb),
                        fontSize: 16,
                        fontFamily: "Lato",
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
