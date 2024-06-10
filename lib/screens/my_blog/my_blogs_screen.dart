import 'package:blog_app/screens/home/widgets/item_blog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/blog.dart';

class MyBlogsScreen extends StatefulWidget {
  const MyBlogsScreen({super.key});

  @override
  State<MyBlogsScreen> createState() => _MyBlogsScreenState();
}

class _MyBlogsScreenState extends State<MyBlogsScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Blogs'),
      ),
      body: StreamBuilder(
          //Show data on app. snapshot is our database
          stream: FirebaseFirestore.instance
              .collection('blogs')
              .where('userId', isEqualTo: user.uid)
              .snapshots(),
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
                padding: const EdgeInsets.all(15),
                children: [for (var blog in blogs) ItemBlog(blog: blog)],
              );
            }

            return SizedBox();
          }),
    );
  }
}
