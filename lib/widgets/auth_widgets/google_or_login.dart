import 'package:flutter/material.dart';
import 'package:todo_firebase/services/auth_services.dart';

import 'components/square_tile.dart';

class GoogleAppleOrLogin extends StatefulWidget {
  final Function()? onTap;

  const GoogleAppleOrLogin({
    super.key,
    required this.onTap,
  });

  @override
  State<GoogleAppleOrLogin> createState() => _GoogleAppleOrLoginState();
}

class _GoogleAppleOrLoginState extends State<GoogleAppleOrLogin> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 25),

        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Row(
            children: [
              Expanded(
                child: Divider(
                  thickness: 0.5,
                  color: Colors.black45,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text('Or Continue with',
                    style: TextStyle(color: Colors.black)),
              ),
              Expanded(
                child: Divider(
                  thickness: 0.5,
                  color: Colors.black45,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 25),

        // google and apple buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SquareTile(
              onTap: () {
                AuthService().signInWithGoogle(
                  showMessage: (message) {
                    // Puedes mostrar el mensaje como desees
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(message),
                      ),
                    );
                  },
                  context: context,
                );
              },
              imagePath: 'assets/google.png',
            ),
          ],
        ),
        const SizedBox(height: 25),

        // dont have an account?
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Do have an account?',
              style: TextStyle(color: Colors.black),
            ),
            const SizedBox(width: 5),
            GestureDetector(
              onTap: widget.onTap,
              child: const Text(
                'Login now',
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        )
      ],
    );
  }
}
