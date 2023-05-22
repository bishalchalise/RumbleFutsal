import "dart:convert";
import "dart:io";

import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:rumble_futsal/main.dart";
import "package:shared_preferences/shared_preferences.dart";

import "../models/auth_model.dart";
import "../providers/dio_provider.dart";
import "../utils/config.dart";

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic> user = {};
  Future<void> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    final loadUser = await DioProvider().getUser(token);

    if (loadUser != 'Error') {
      setState(() {
        user = json.decode(loadUser);
        print(user);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 4,
          child: Container(
            width: double.infinity,
            color: Config.primaryColor,
            child: Consumer<AuthModel>(
              builder: (context, auth, child) {
                final user = auth.getUser;

                return Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 110,
                    ),
                    CircleAvatar(
                      radius: 65.0,
                      backgroundImage: user['profile_photo_path'] != null
                          ? FileImage(File(user['profile_photo_path']))
                          : null,
                      backgroundColor: Colors.white,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Name: ${user['name'] ?? ''}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Email: ${user['email'] ?? ''}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Address: ${user['address'] ?? 'N/A'}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Phone: ${user['phone'] ?? 'N/A'}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Position: ${user['position'] ?? 'N/A'}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Container(
            color: Colors.grey[200],
            child: Center(
              child: Card(
                margin: const EdgeInsets.fromLTRB(0, 45, 0, 0),
                child: Container(
                  width: 300,
                  height: 250,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        const Text(
                          'Profile',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Divider(
                          color: Colors.grey[300],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.edit_document,
                              color: Colors.blueAccent[400],
                              size: 35,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            TextButton(
                              onPressed: () {
                                MyApp.navigatorKey.currentState!
                                    .pushReplacementNamed('personal_info');
                              },
                              child: const Text(
                                "Edit Profile",
                                style: TextStyle(
                                  color: Config.primaryColor,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Config.spaceSmall,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.history,
                              color: Colors.yellowAccent[400],
                              size: 35,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                "History",
                                style: TextStyle(
                                  color: Config.primaryColor,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Config.spaceSmall,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.logout_outlined,
                              color: Colors.lightGreen[400],
                              size: 35,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            TextButton(
                              onPressed: () async {
                                final SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                final token = prefs.getString('token') ?? '';

                                if (token.isNotEmpty && token != '') {
                                  //logout here
                                  final response =
                                      await DioProvider().logout(token);

                                  if (response == 200) {
                                    //if successfully delete access token
                                    //then delete token saved at Shared Preference as well
                                    await prefs.clear();
                                    await prefs.remove('token');

                                    setState(() {
                                      //  await  prefs.remove('user');
                                      //redirect to login page
                                      MyApp.navigatorKey.currentState!
                                          .pushReplacementNamed('/');
                                    });
                                  } else {
                                    print('Error logging out');
                                  }
                                }
                              },
                              child: const Text(
                                "Logout",
                                style: TextStyle(
                                  color: Config.primaryColor,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
