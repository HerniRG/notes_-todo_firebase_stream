import 'package:flutter/material.dart';
import 'package:todo_firebase/services/auth_services.dart';
import '../../widgets/auth_widgets/components/my_button.dart';
import '../../widgets/auth_widgets/google_or_login.dart';
import '../../widgets/auth_widgets/icon_text_header.dart';
import '../../widgets/auth_widgets/textfields_forgotpass_register.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;

  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmationController = TextEditingController();
  final AuthService _authService = AuthService();

  Future<void> signUserUp() async {
    await _authService.signUserUp(
      email: emailController.text,
      password: passwordController.text,
      passwordConfirmation: passwordConfirmationController.text,
      showMessage: showMessage,
      context: context,
    );
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.yellow.shade100,
      body: SafeArea(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 5),
              const IconAndTextHeader(
                icon: Icons.lock,
                title: 'Register',
                subtitle: 'Let\'s create an Notes Cloud account',
              ),
              TextFieldsRegister(
                  emailController: emailController,
                  passwordController: passwordController,
                  passwordConfirmationController:
                      passwordConfirmationController),
              // signin button
              MyButton(
                onTap: signUserUp,
                text: 'Register',
              ),
              GoogleAppleOrLogin(
                onTap: widget.onTap,
              ),
              const SizedBox(height: 5)
            ]),
      ),
    );
  }
}
