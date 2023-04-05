// ignore_for_file: use_build_context_synchronously
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';


import 'package:blog_app/Auth/log_in.dart';
import 'package:blog_app/Utils/show_message.dart';
import 'package:blog_app/Windows/my_home_page.dart';
import 'package:blog_app/Windows/profile.dart';
import 'package:blog_app/Utils/theme_changer.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}  ) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  // @override
  // void initState() {
  //   print('build');
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {

    ThemeChanger theme = Provider.of<ThemeChanger>(context);

    return Scaffold(

      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    const Positioned(
                      left: 10,
                      bottom: 50,
                      child: CircleAvatar(
                        foregroundColor: Colors.green,
                        radius: 60,
                        child: Image(
                          image: AssetImage('Assets/Logo/logo.png'),
                        ),
                      ),
                    ),
                    const Positioned(
                      left: 25,
                      bottom: 10,
                      child: Text(
                        'your Name',
                        style: TextStyle(
                          fontSize: 26,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                listWidgetCard(
                  const Icon(
                    Icons.signpost,
                    size: 40,
                  ),
                  'Blogs',
                  () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyHomePage(),
                      ),
                    );
                  },
                ),
                listWidgetCard(
                  const Icon(
                    Icons.person,
                    size: 40,
                  ),
                  'Profile',
                  () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfilePage(),
                      ),
                    );
                  },
                ),
                listWidgetCard(
                  const Icon(
                    Icons.dark_mode,
                    size: 40,
                  ),
                  'Change Theme',
                  () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: const Text('Change Theme'),
                              content: SizedBox(
                                height: 200,
                                child: Column(
                                  children: [
                                    RadioListTile<ThemeMode>(
                                      value: ThemeMode.light,
                                      groupValue: theme.themeMode,
                                      title: const Text('Light Mode'),
                                      onChanged: (v) {
                                        theme.setThemeMod(v);
                                        Utils(
                                                message: 'Theme Changed $v',
                                                color: Colors.blue)
                                            .showMessage();
                                      },
                                    ),
                                    RadioListTile<ThemeMode>(
                                      value: ThemeMode.dark,
                                      title: const Text('Dark Mode'),
                                      groupValue: theme.themeMode,
                                      onChanged: (v) {
                                        if (kDebugMode) {
                                          print(v);
                                        }
                                        theme.setThemeMod(v);
                                        Utils(
                                                message: 'Theme Changed $v',
                                                color: Colors.blue)
                                            .showMessage();
                                      },
                                    ),
                                    RadioListTile<ThemeMode>(
                                      value: ThemeMode.system,
                                      title: const Text('System Mode'),
                                      groupValue: theme.themeMode,
                                      onChanged: (v) {
                                        if (kDebugMode) {
                                          print(v);
                                        }
                                        theme.setThemeMod(v);
                                        Utils(
                                                message: 'Theme Changed $v',
                                                color: Colors.blue)
                                            .showMessage();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ));
                  },
                ),
              ],
            ),
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Exit'),
                        content: const Text(
                          'Are you sure you want to Log Out ?',
                          textAlign: TextAlign.center,
                        ),
                        actions: [
                          TextButton(
                            onPressed: () async {
                              try {
                                final FirebaseAuth auth = FirebaseAuth.instance;
                                await auth.signOut();
                                Utils(message: 'Log out', color: Colors.red)
                                    .showMessage();

                                Navigator.pop(context, true);

                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LogIn(),
                                  ),
                                );
                              } catch (e) {
                                Utils(message: e.toString(), color: Colors.red)
                                    .showMessage();
                              }
                            },
                            child: const Text('Yes'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context, false);
                            },
                            child: const Text('No'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: const Text(
                    'Log Out',
                    // style: TextStyle(
                    //   color: Colors.white,
                    // ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget listWidgetCard(Icon icon, String title, Function onTap) {
    return Card(
      elevation: 2,
      child: ListTile(
        leading: icon,
        title: Text(title),
        onTap: () => onTap(),
      ),
    );
  }
}
