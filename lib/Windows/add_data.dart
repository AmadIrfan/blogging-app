import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

class MyDetails extends StatefulWidget {
  const MyDetails({super.key});

  @override
  State<MyDetails> createState() => _MyDetailsState();
}

class _MyDetailsState extends State<MyDetails> {
  File? _profileImage;
  ImagePicker img = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Profile",
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                bottomSheet();
              },
              child: Container(
                margin: const EdgeInsets.all(
                  10,
                ),
                height: 200,
                // padding: const EdgeInsets.all(5),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 2),
                ),
                child: _profileImage != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image(
                          image: FileImage(
                            _profileImage!.absolute,
                          ),
                          fit: BoxFit.cover,
                        ),
                      )
                    : CircleAvatar(
                        radius: 50,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image(
                            image: AssetImage(
                              'Assets/Logo/profileimage.png',
                            ),
                          ),
                        ),
                      ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  child: ListView(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text(
                            "Name",
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text(
                            "About",
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        maxLines: null,
                        minLines: 2,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text(
                            "Skills",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void bottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              height: 100,
              color: Theme.of(context).primaryColor,
              child: Center(
                child: Text(
                  'Select Profile Picture',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(vertical: 30, horizontal: 50),
                    ),
                    onPressed: () async {
                      final imagePick = await img.pickImage(
                        source: ImageSource.camera,
                      );
                      if (imagePick != null) {
                        _profileImage = File(imagePick.path);
                        setState(() {});
                      }
                      Navigator.pop(context, true);
                    },
                    icon: Icon(
                      Icons.camera,
                    ),
                    label: Text('Camera'),
                  ),
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(vertical: 30, horizontal: 50),
                    ),
                    onPressed: () async {
                      final imagePick = await img.pickImage(
                        source: ImageSource.gallery,
                      );
                      if (imagePick != null) {
                        _profileImage = File(
                          imagePick.path,
                        );
                        setState(() {});
                      }
                      Navigator.pop(context, true);
                    },
                    icon: Icon(
                      Icons.image,
                    ),
                    label: Text('Gallery'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
