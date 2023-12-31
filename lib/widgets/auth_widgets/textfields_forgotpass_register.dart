import 'package:flutter/material.dart';
import 'components/my_textfield.dart';

class TextFieldsRegister extends StatelessWidget {
  const TextFieldsRegister({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.passwordConfirmationController,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController passwordConfirmationController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyTextField(
          controller: emailController,
          hintText: 'Email',
          obscureText: false,
        ),

        const SizedBox(height: 10),

        // password textfield
        MyTextField(
          controller: passwordController,
          hintText: 'Password',
          obscureText: true,
        ),

        const SizedBox(height: 10),

        // re-password textfield
        MyTextField(
          controller: passwordConfirmationController,
          hintText: 'Confirm Password',
          obscureText: true,
        ),
        const SizedBox(height: 10),
        // forgot password?
      ],
    );
  }
}
