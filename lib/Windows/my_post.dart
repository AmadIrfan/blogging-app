import 'package:blog_app/Utils/show_message.dart';
import 'package:blog_app/Windows/my_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyPost extends StatelessWidget {
  MyPost({super.key});

  final FirebaseAuth user = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    String? userId = user.currentUser?.uid;
    return Scaffold(
      drawer: Drawer(
        child: MyDrawer(),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'My Post',
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 0.9,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users/${userId}/UserPostedIdes')
              .snapshots(),
          builder: (context, snapShot) {
            if (snapShot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapShot.data!.docs.isEmpty) {
              return Center(
                child: Text(
                  'No Posts',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapShot.data?.docs.length,
                itemBuilder: (context, index) {
                  final da = snapShot.data?.docs;
                  // da?[index].id
                  return StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Blog')
                        .doc(
                          da?[index].id,
                        )
                        .snapshots(),
                    builder: (context, snap) {
                      final d = snap.data?.data();
                      return InkWell(
                        onTap: () {
                          print('opTap');
                          Utils(
                                  message:
                                      'App is in development, Preview feature will be added soon')
                              .showMessage();
                        },
                        child: Card(
                          child: Container(
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  contentPadding: const EdgeInsets.all(10),
                                  style: ListTileStyle.list,
                                  leading: CircleAvatar(
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
                                  trailing: PopupMenuButton(
                                    onSelected: (value) {
                                      if (PopUpValue.delete == value) {
                                        try {
                                          print("${d?['postId']}");
                                          FirebaseFirestore.instance
                                              .collection('Blog')
                                              .doc("${d?['postId']}")
                                              .delete();
                                          FirebaseFirestore.instance
                                              .collection(
                                                  'users/${userId}/UserPostedIdes')
                                              .doc("${d?['postId']}")
                                              .delete();
                                          Utils(message: 'Post Deleted')
                                              .showMessage();
                                        } catch (e) {
                                          Utils(
                                            message: e.toString(),
                                          ).showMessage();
                                        }
                                      } else {
                                        Utils(
                                                message:
                                                    'App is in development Edit feature will be added soon')
                                            .showMessage();

                                        print("Edit");
                                      }
                                    },
                                    itemBuilder: (context) => [
                                      PopupMenuItem(
                                        child: Text("Delete"),
                                        value: PopUpValue.delete,
                                      ),
                                      PopupMenuItem(
                                        child: Text("Edit"),
                                        value: PopUpValue.edit,
                                      ),
                                    ],
                                  ),
                                ),
                                ListTile(
                                  title: Text(
                                    "${d?['title']}",
                                  ),
                                  subtitle: Text(
                                    "${d?['body']}",
                                  ),
                                ),
                                Divider(),
                                Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: "${d?['imagePost']}".isEmpty ||
                                                "${d?['imagePost']}" == "null"
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
                                                image: "${d?['imagePost']}"
                                                    .toString(),
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
                      // Text(
                      //   "${d?['title']} S\n",
                      // );
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

enum PopUpValue {
  delete,
  edit,
}
