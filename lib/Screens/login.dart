import 'package:flutter/material.dart';
import 'package:login_ui/Components/custom_button.dart';
import 'package:login_ui/Components/custom_textfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isRememberMe = false;

  @override
  void initState() {
    _loadSavedCredentials();
    super.initState();
  }

  /// Load saved email and password if "Remember Me" was checked before
  Future<void> _loadSavedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isRememberMe = prefs.getBool('remember_me') ?? false;
      if (isRememberMe) {
        _emailController.text = prefs.getString('email') ?? '';
        _passwordController.text = prefs.getString('password') ?? '';
      }
    });
  }

  /// Save or remove credentials based on "Remember Me" checkbox
  Future<void> _handleRememberMe(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isRememberMe = value;
    });
    if (isRememberMe) {
      await prefs.setString('email', _emailController.text);
      await prefs.setString('password', _passwordController.text);
      await prefs.setBool('remember_me', isRememberMe);
    } else {
      await prefs.remove('email');
      await prefs.remove('password');
      await prefs.remove('remember_me');
    }
  }

  void _login() async {
    if (_formKey.currentState == null || !_formKey.currentState!.validate()) {
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    String? savedEmail = prefs.getString('registered_email');
    String? savedPassword = prefs.getString('registered_password');

    String enteredEmail = _emailController.text.trim();
    String enteredPassword = _passwordController.text.trim();

    if (enteredEmail == savedEmail && enteredPassword == savedPassword) {
      await _handleRememberMe(isRememberMe);
      Navigator.pushNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Invalid email or password. Please try again.",
            style: TextStyle(
                color: Color.fromARGB(255, 233, 14, 14),
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: "Lato"),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 70),
          child: Form(
            key: _formKey,
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
                Center(
                    child: CustomTextfield(
                  hintText: 'Email',
                  obscureText: false,
                  controller: _emailController,
                )),
                Center(
                    child: CustomTextfield(
                        hintText: 'Password',
                        obscureText: true,
                        controller: _passwordController)),
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
                          _handleRememberMe(value ?? false);
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
                    onPressed: _login,
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
                      onPressed: () =>
                          Navigator.pushNamed(context, '/register'),
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
      ),
    );
  }
}
