import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'get_started.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _signUp() async {
    try {
      print("Starting signup process...");

      // Check Firebase app connection status
      if (FirebaseAuth.instance.app.options == null) {
        print("Firebase app is not initialized. Check Firebase configuration.");
        return;
      } else {
        print("Firebase app is initialized.");
      }

      // Extract email and password from text controllers
      String email = emailController.text;
      String password = passwordController.text;

      print("Email: $email");

      // Sign up user with email and password
      print("Signing up user...");
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      print("User signed up successfully. User ID: ${userCredential.user!.uid}");

      // Store additional user data in Firestore
      print("Storing user data in Firestore...");
      await FirebaseFirestore.instance.collection('users').add({
        'userId': userCredential.user!.uid,
        'email': email,
        // Add more user data if needed
      });

      print("User data stored in Firestore successfully.");

      // Navigate to next screen after successful signup
      print("Navigating to GetStarted screen...");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => GetStarted()));

      // Show a Snackbar to indicate successful signup
      print("Showing Snackbar for successful signup...");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Signed up successfully!'),
          duration: Duration(seconds: 2), // Adjust the duration as needed
        ),
      );

      print("Signup process completed.");
    } catch (e) {
      // Handle signup errors
      print("Error signing up: $e");
      // You can show a snackbar or dialog to display the error message
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Sign Up'),
        leading: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => GetStarted()));
          },
          child: Icon(Icons.arrow_back_ios),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email',
                prefixIcon: Icon(Icons.email),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your password',
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _signUp,
              child: Text('Sign Up'),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                // Navigate back to login screen
                Navigator.pop(context);
              },
              child: Text(
                'Already have an account? Login',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
