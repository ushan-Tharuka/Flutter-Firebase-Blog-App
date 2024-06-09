import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //controller for get text from text feild
  final email = TextEditingController();
  final password = TextEditingController();
  //validate form
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(15),
          children: [
            const SizedBox(height: 100),
            Text('Login', style: Theme.of(context).textTheme.displaySmall),
            const Text('Please enter Email and Password to get started.'),
            const SizedBox(height: 40),
            TextFormField(
              decoration: const InputDecoration(hintText: 'Email'),
              //if not Enter email
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter Email';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(hintText: 'Password'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter Password';
                }
                return null;
              },
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {}
              },
              child: const Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
