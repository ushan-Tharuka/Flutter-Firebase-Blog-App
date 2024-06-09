import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          const SizedBox(height: 100),
          Text('Login', style: Theme.of(context).textTheme.displaySmall),
          Text('Please enter Email and Password to get started.'),
          const SizedBox(height: 40),
          TextFormField(
            decoration: InputDecoration(hintText: 'Email'),
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(hintText: 'Password'),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {},
            child: const Text("Login"),
          ),
        ],
      ),
    );
  }
}
