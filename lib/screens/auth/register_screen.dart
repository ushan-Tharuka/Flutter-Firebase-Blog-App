import 'package:blog_app/screens/auth/login_screen.dart';
import 'package:blog_app/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  //controller for get text from text feild
  final name = TextEditingController();
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
                  Text('Register',
                      style: Theme.of(context).textTheme.displaySmall),
                  const Text('Enter Name, Email and Password to get started.'),
                  const SizedBox(height: 40),
                  TextFormField(
                    controller: name,
                    decoration: const InputDecoration(hintText: 'Name'),
                    //if not Enter email
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
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
                    controller: password,
                    obscureText: true,
                    decoration: const InputDecoration(hintText: 'Password'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 40),
                  loading
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              setState(() {
                                loading = true;
                              });
                              startRegister();
                            }
                          },
                          child: const Text("Register"),
                        ),
                ],
              ),
            ),
          ),
          OutlinedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()));
            },
            child: const Text("Already have an account? Login now"),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  //Register funtion
  startRegister() async {
    try {
      final result = await auth.createUserWithEmailAndPassword(
          email: email.text, password: password.text);
      await result.user?.updateDisplayName(name.text);
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
