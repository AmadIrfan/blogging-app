import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'add_post.dart';
import 'my_drawer.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// void getData() async {
//   var collection =
//       await FirebaseFirestore.instance.collection('Blog').snapshots();
// }

class _MyHomePageState extends State<MyHomePage> {
  FirebaseAuth user = FirebaseAuth.instance;

  final stream = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    String? userId = user.currentUser?.uid;
    return Scaffold(
      drawer: const Drawer(
        child: MyDrawer(),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddPost(),
                ),
              );
            },
            icon: const Icon(
              Icons.add,
            ),
          ),
        ],
        title: const Text(
          'Blogs',
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: stream.collection('Blog').snapshots(),
        builder: (context, snapShot) {
          print("length " + "${snapShot.data?.docs.length}");
          if (snapShot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapShot.hasError) {
            return Text(snapShot.data.toString());
          } else {
            // return Text("data");
            return SizedBox(
              height: 500,
              child: ListView.builder(
                itemCount: snapShot.data!.docs.length,
                itemBuilder: (context, index) {
                  print(snapShot.data?.docs.length);
                  return Text(
                    snapShot.data!.docs[index].id,
                    style: TextStyle(color: Colors.red),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
