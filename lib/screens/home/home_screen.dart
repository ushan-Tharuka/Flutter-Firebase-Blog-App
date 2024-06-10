import 'package:blog_app/models/blog.dart';
import 'package:blog_app/screens/add_blog/add_blog_screen.dart';
import 'package:blog_app/screens/auth/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          //logout button
          PopupMenuButton(
              itemBuilder: (context) => [
                    PopupMenuItem(
                      onTap: () async {
                        //sign out user
                        final auth = FirebaseAuth.instance;
                        await auth.signOut();
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const LoginScreen()),
                            (route) => false);
                      },
                      child: const Text('Logout'),
                    ),
                  ]),
        ],
      ),
      body: StreamBuilder(
          //Show data on app. snapshot is our database
          stream: FirebaseFirestore.instance.collection('blogs').snapshots(),
          builder: (context, snapshot) {
            //when user open app load data in app
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            //has data show here
            if (snapshot.hasData && snapshot.data != null) {
              final data = snapshot.data!.docs;

              //convert data list of blog
              List<Blog> blogs = [];
              for (var element in data) {
                //convert
                Blog blog = Blog.fromMap(element.data());
                blogs.add(blog);
              }
              return ListView(
                children: [
                  for (var blog in blogs)
                    ListTile(
                      title: Text(blog.title),
                      subtitle: Text(blog.desc),
                    )
                ],
              );
            }

            return SizedBox();
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const AddBlogScreen()));
        },
        child: const Icon(CupertinoIcons.plus),
      ),
    );
  }
}
