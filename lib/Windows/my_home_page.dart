import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Utils/show_message.dart';
import 'add_post.dart';
import 'my_drawer.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// void getData() async {
//   await FirebaseFirestore.instance
//       .collection('/Blog')
//       .get()
//       .then((event) => event.docs.forEach(
//             (element) {
//               print("Id ${event.docs.length}");
//             },
//           ));

//   print('done');
// }

class _MyHomePageState extends State<MyHomePage> {
  FirebaseAuth user = FirebaseAuth.instance;

  final stream = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    // String? userId = user.currentUser?.uid;
    // getData();
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
          if (snapShot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapShot.hasError) {
            return Text(
              snapShot.data.toString(),
            );
          } else if (snapShot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                'No Blogs Available',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            );
          } else {
            // return Text("data");
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              child: ListView.builder(
                itemCount: snapShot.data!.docs.length,
                itemBuilder: (context, index) {
                  final docs = snapShot.data!.docs[index];
                  return Card(
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: InkWell(
                        onTap: () {
                          Utils(
                                  message:
                                      'App is in development Preview feature will be added soon')
                              .showMessage();
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 10,
                                left: 10,
                              ),
                              child: CircleAvatar(
                                radius: 30,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Image(
                                    image: AssetImage(
                                      'Assets/Logo/images1.jpeg',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            ListTile(
                              title: Text(
                                docs['title'],
                              ),
                              subtitle: Text(
                                docs['body'].toString(),
                              ),
                            ),
                            Divider(),
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: docs['imagePost'].toString().isEmpty
                                        ? Image(
                                            image: AssetImage(
                                              'Assets/Logo/logo.png',
                                            ),
                                            fit: BoxFit.cover,
                                          )
                                        : FadeInImage.assetNetwork(
                                            fadeInDuration: Duration(
                                              seconds: 1,
                                            ),
                                            fadeOutDuration: Duration(
                                              seconds: 2,
                                            ),
                                            placeholder:
                                                'Assets/Logo/image.gif',
                                            image: docs['imagePost'].toString(),
                                          ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                  // : Center(
                  //     child: Text(
                  //       'No Blogs Available',
                  //       style: TextStyle(
                  //         color: Colors.black,
                  //       ),
                  //     ),
                  // );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
