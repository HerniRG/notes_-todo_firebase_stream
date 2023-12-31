import 'package:flutter/material.dart';
import 'package:todo_firebase/services/auth_services.dart';
import '../../widgets/auth_widgets/components/my_button.dart';
import '../../widgets/auth_widgets/google_or_register.dart';
import '../../widgets/auth_widgets/icon_text_header.dart';
import '../../widgets/auth_widgets/textfields_forgotpass_login.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  Future<void> signUserIn() async {
    await _authService.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
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
                  icon: Icons.note_alt_rounded,
                  title: 'Login',
                  subtitle:
                      'Welcome to Notes Cloud, I hope you have a good day!'),
              TextFieldsAndFogotPassLogin(
                  emailController: emailController,
                  passwordController: passwordController),
              // signin button
              MyButton(
                onTap: signUserIn,
                text: 'Login',
              ),
              GoogleAppleOrRegister(
                onTap: widget.onTap,
              ),
              const SizedBox(height: 5)
            ]),
      ),
    );
  }
}
