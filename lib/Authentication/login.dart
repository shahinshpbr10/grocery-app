import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/Authentication/get_started.dart';
import 'package:grocery_app/user/userhome.dart';
import '../admin/adminhome.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  void _login() {
    // Directly navigate based on the tab index without authentication
    if (_tabController.index == 0) {
      // User tab
      Get.offAll(() => UserHome());
    } else {
      // Admin tab
      Get.offAll(() => AdminHome()); // Navigate to your Admin Home Page
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'User'),
            Tab(text: 'Admin'),
          ],
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => GetStarted()));
          },
          child: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildLoginForm(), // User login form
          _buildLoginForm(), // Admin login form; you can customize this if needed
        ],
      ),
    );
  }

  Widget _buildLoginForm() {
    return Container(
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
            onPressed: _login,
            child: Text('Login'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    _tabController.dispose();
    super.dispose();
  }
}
