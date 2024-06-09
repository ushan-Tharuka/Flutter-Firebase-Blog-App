import 'package:blog_app/screens/auth/register_screen.dart';
import 'package:blog_app/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final auth = FirebaseAuth.instance;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Form(
              key: formKey,
              child: ListView(
                padding: const EdgeInsets.all(15),
                children: [
                  const SizedBox(height: 100),
                  Text('Login',
                      style: Theme.of(context).textTheme.displaySmall),
                  const Text('Enter Email and Password to get started.'),
                  const SizedBox(height: 40),
                  TextFormField(
                    controller: email,
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
                    obscureText: true,
                    controller: password,
                    decoration: const InputDecoration(hintText: 'Password'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 40),
                  //loading button
                  loading
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              setState(() {
                                loading = true;
                              });
                              startLogin();
                            }
                          },
                          child: const Text("Login"),
                        ),
                ],
              ),
            ),
          ),
          OutlinedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const RegisterScreen()));
            },
            child: const Text("Don't have an account? Register now"),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

//Login funtion
  startLogin() async {
    try {
      await auth.signInWithEmailAndPassword(
          email: email.text, password: password.text);
      setState(() {
        loading = false;
      });
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
          (route) => false);
    } on FirebaseException catch (e) {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message ?? ''),
      ));
    }
  }
}
