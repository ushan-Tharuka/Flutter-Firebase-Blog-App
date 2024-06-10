import 'package:blog_app/models/blog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddBlogScreen extends StatefulWidget {
  const AddBlogScreen({super.key});

  @override
  State<AddBlogScreen> createState() => _AddBlogScreenState();
}

class _AddBlogScreenState extends State<AddBlogScreen> {
  //Create variables
  final title = TextEditingController();
  final desc = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Blog"),
        actions: [
          IconButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                setState(() {
                  loading = true;
                });
                addBlog();
              }
            },
            icon: const Icon(Icons.done),
          )
        ],
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Form(
              //Enable form key Validation
              key: formKey,
              child: ListView(
                padding: const EdgeInsets.all(15),
                children: [
                  TextFormField(
                    controller: title,
                    decoration: const InputDecoration(
                      hintText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                    //Add validator for adding title
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter title";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: desc,
                    maxLines: 13,
                    decoration: const InputDecoration(
                      hintText: 'description',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter Description";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
    );
  }

  //add blog to firebase
  addBlog() async {
    // create firestore instatnce
    final db = FirebaseFirestore.instance.collection('blogs');
    // Add data
    final user = FirebaseAuth.instance.currentUser!;
    final id = DateTime.now().microsecondsSinceEpoch.toString();
    Blog blog = Blog(
      id: id,
      userId: user.uid,
      title: title.text,
      desc: desc.text,
      createdAt: DateTime.now(),
    );
    //pass to map fro send to datebase
    try {
      await db.doc(id).set(blog.toMap());
      setState(() {
        loading = false;
      });
      //after add close add blog page
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      setState(() {
        loading = false;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.message ?? ''),
        ));
      });
    }
  }
}
