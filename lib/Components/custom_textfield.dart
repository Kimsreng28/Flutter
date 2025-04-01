import 'package:flutter/material.dart';

class CustomTextfield extends StatefulWidget {
  final String hintText;
  final bool obscureText;

  const CustomTextfield({
    super.key,
    required this.hintText,
    required this.obscureText,
  });

  @override
  _CustomTextfieldState createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextField(
        style: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.w400, fontFamily: "Lato"),
        obscureText: _isObscured,
        decoration: InputDecoration(
          hintText: widget.hintText,
          filled: true,
          fillColor: const Color(0xFFF1F1F5),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
          suffixIcon: widget.obscureText
              ? IconButton(
                  icon: Icon(
                    _isObscured ? Icons.visibility_off : Icons.visibility,
                    color: const Color.fromARGB(255, 157, 157, 156),
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscured = !_isObscured;
                    });
                  },
                )
              : null,
        ),
      ),
    );
  }
}
