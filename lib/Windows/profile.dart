import 'package:blog_app/Windows/add_data.dart';
import 'package:flutter/material.dart';

import 'package:blog_app/Windows/my_drawer.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final List<String> _items = [
    'Flutter',
    'C++',
    'C#',
    'Sql',
    'Dart',
    'UI/UX Design',
    'FireBase'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MyDetails(),
                ),
              );
            },
            icon: const Icon(
              Icons.edit,
            ),
            tooltip: 'Edit Profile',
          ),
        ],
        backgroundColor: Colors.transparent,
      ),
      drawer: const Drawer(
        child: MyDrawer(),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColor,
            ],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 50),
            const CircleAvatar(
              foregroundColor: Colors.green,
              radius: 80,
              backgroundImage: AssetImage('Assets/Logo/logo.png'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Amad Irfan',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Software Engineer',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(1),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      const Text(
                        'About Me',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec volutpat nisi eget sapien fringilla, vel tempor elit volutpat. Nunc congue bibendum erat, ut vestibulum est ultricies non.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        'Skills',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 15,
                        children: [
                          SizedBox(
                            height: 50,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _items.length,
                              itemBuilder: (context, index) => Chip(
                                label: Text(
                                  _items[index],
                                ),
                                backgroundColor: Colors.blue[800],
                                labelStyle:
                                    const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          // Chip(
                          //   label: const Text('Dart'),
                          //   backgroundColor: Colors.blue[800],
                          //   labelStyle: const TextStyle(color: Colors.white),
                          // ),
                          // Chip(
                          //   label: const Text('Firebase'),
                          //   backgroundColor: Colors.blue[800],
                          //   labelStyle: const TextStyle(color: Colors.white),
                          // ),
                          // Chip(
                          //   label: const Text('UI/UX Design'),
                          //   backgroundColor: Colors.blue[800],
                          //   labelStyle: const TextStyle(color: Colors.white),
                          // ),
                        ],
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
}
