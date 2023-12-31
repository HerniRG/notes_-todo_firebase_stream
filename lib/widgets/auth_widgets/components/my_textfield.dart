import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  late bool obscureText;

  @override
  void initState() {
    super.initState();
    obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: widget.controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black26),
          ),
          fillColor: Colors.grey.shade400,
          filled: true,
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: Colors.black),
          suffixIcon: widget.obscureText
              ? InkWell(
                  onTap: () {
                    toggleVisibility();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: obscureText
                        ? const Icon(Icons.visibility_off)
                        : const Icon(Icons.visibility),
                  ),
                )
              : null,
        ),
      ),
    );
  }

  void toggleVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }
}
