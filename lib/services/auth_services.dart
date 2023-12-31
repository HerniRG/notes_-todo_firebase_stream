import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign in with email and password
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
    required Function showMessage,
    required BuildContext context,
  }) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(width: 16),
            Text('Signing in...'),
          ],
        ),
      ),
    );

    try {
      if (email.isEmpty || password.isEmpty) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        showMessage('Please enter both email and password.');
        return;
      }

      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      showMessage('Login successful!');
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      if (kDebugMode) {
        print('FirebaseAuthException: ${e.code}');
      }
      if (e.code == 'user-not-found') {
        showMessage('No user found with that email.');
      } else if (e.code == 'wrong-password') {
        showMessage('Wrong password. Please try again.');
      } else if (e.code == 'invalid-email' || e.code == 'user-disabled') {
        showMessage('Authentication failed. Please check your credentials.');
      } else {
        showMessage('Authentication failed. Please try again.');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      if (kDebugMode) {
        print('Unexpected error: $e');
      }
      showMessage('Authentication failed. Please try again.');
    }
  }

  // Sign up with email and password
  Future<void> signUserUp({
    required String email,
    required String password,
    required String passwordConfirmation,
    required Function showMessage,
    required BuildContext context,
  }) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(width: 16),
            Text('Signing up...'),
          ],
        ),
      ),
    );

    try {
      if (email.isEmpty || password.isEmpty || passwordConfirmation.isEmpty) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        showMessage('Please enter email and passwords.');
        return;
      }

      if (password != passwordConfirmation) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        showMessage('Passwords do not match. Please try again.');
        return;
      }

      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      showMessage('Registration successful!');
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      if (e.code == 'email-already-in-use') {
        showMessage('The account already exists for that email.');
      } else {
        showMessage('Authentication failed. Please try again.');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      showMessage('Authentication failed. Please try again.');
    }
  }

  // Sign out
  Future<void> signUserOut({
    required Function showMessage,
    required BuildContext context,
  }) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(width: 16),
            Text('Signing out...'),
          ],
        ),
      ),
    );

    try {
      await _auth.signOut();
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      showMessage('Sign out successful!');
    } catch (e) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      showMessage('Error signing out. Please try again.');
      print('Error signing out: $e');
    }
  }

  // Forgot password
  Future<void> forgotPassword({
    required String email,
    required Function showMessage,
    required BuildContext context,
  }) async {
    try {
      if (email.trim().isEmpty) {
        showMessage('No email provided. Please enter your email address.');
        return;
      }

      // Validar formato de correo electrónico
      if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
          .hasMatch(email.trim())) {
        showMessage(
            'Invalid email format. Please enter a valid email address.');
        return;
      }

      await _auth.sendPasswordResetEmail(email: email.trim());

      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      showMessage('Password reset email sent. Check your inbox.');
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      showMessage(e.message.toString());
    }
  }

  // Google sign in
  Future<void> signInWithGoogle({
    required Function showMessage,
    required BuildContext context,
  }) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(width: 16),
            Text('Signing in with Google...'),
          ],
        ),
      ),
    );

    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        showMessage('Google sign in canceled.');
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      showMessage('Google login successful!');
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      showMessage('Google sign in failed. ${e.message}');
    }
  }
}
