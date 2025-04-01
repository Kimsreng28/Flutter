import 'package:flutter/material.dart';
import 'package:login_ui/Components/custom_button.dart';
import 'package:login_ui/Components/custom_textfield.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isTermAndCondition = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Register new \naccount',
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
              const Center(
                  child: CustomTextfield(
                      hintText: 'Confirmed Password', obscureText: true)),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Row(
                    children: [
                      Checkbox(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        value: isTermAndCondition,
                        onChanged: (value) {
                          setState(() {
                            isTermAndCondition = value!;
                          });
                        },
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'By create an account, your agree to our',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: "Lato",
                            ),
                          ),
                          Text(
                            'Terms & Conditions',
                            style: TextStyle(
                              color: Color(0xFF2c74fb),
                              fontSize: 16,
                              fontFamily: "Lato",
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
              const SizedBox(height: 5),
              Center(
                child: CustomButton(
                  text: 'Register',
                  color: const Color(0xFF2c74fb),
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  style: const TextStyle(
                    color: Colors.white,
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
                    'Already have an account!',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: "Lato",
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/login'),
                    child: const Text(
                      'Login',
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
