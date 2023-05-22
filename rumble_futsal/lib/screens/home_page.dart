import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rumble_futsal/components/booking_card.dart';
import 'package:rumble_futsal/components/ground_card.dart';
import 'package:rumble_futsal/main.dart';
import 'package:rumble_futsal/models/auth_model.dart';
import 'package:rumble_futsal/utils/config.dart';
import 'package:rumble_futsal/utils/text.dart';
import 'full_size_photo.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Map<String, dynamic> user = {};
  // Map<String, dynamic> reviews = {};
  Map<String, dynamic> ground = {};
  Map<String, dynamic> booking = {};
  List<dynamic> favList = [];
  Map<String, dynamic> cancel = {};

  List<Map<String, dynamic>> futCat = [
    {
      "icon": FontAwesomeIcons.football,
      "category": "Book Ground",
      "onPressed": () {
        MyApp.navigatorKey.currentState!.pushNamed('all_grounds');
      },
    },
    {
      "icon": FontAwesomeIcons.person,
      "category": "Select Referee",
      "onPressed": () {
        MyApp.navigatorKey.currentState!.pushNamed('referee');
      },
    },
  ];
  void _viewFullSizeImage(String imagePath) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullSizeImagePage(imagePath: imagePath),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);

    return Consumer<AuthModel>(
      builder: (
        context, authModel, child) 
        {
    user = Provider.of<AuthModel>(context, listen: false).getUser;
    ground = Provider.of<AuthModel>(context, listen: false).getBooking;
    favList = Provider.of<AuthModel>(context, listen: false).getFav;
    cancel = Provider.of<AuthModel>(context, listen: false).getBooking;
    return Scaffold(
      //id user empty then return progress indicator
      body: user.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 15,
              ),
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppText.enText['welcome_text']!,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Config.primaryColor,
                                ),
                              ),
                              Text(
                                user[
                                    'name'], //hard core the user's name at first
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Config.primaryColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            child: GestureDetector(
                              onTap: () {
                                if (user['profile_photo_path'] != null) {
                                  _viewFullSizeImage(
                                      user['profile_photo_path']);
                                }
                              },
                              child: Hero(
                                tag: 'profile_photo',
                                child: CircleAvatar(
                                  radius: 30.0,
                                  backgroundImage:
                                      user['profile_photo_path'].isNotEmpty
                                          ? FileImage(
                                              File(user['profile_photo_path']))
                                          : null,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Config.spaceMedium,
                      const Text(
                        'Category', //hard core the user's name at first
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Config.spaceSmall,
                      SizedBox(
                        height: Config.heightSize * 0.05,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: List<Widget>.generate(
                            futCat.length,
                            (index) {
                              return Card(
                                margin: const EdgeInsets.only(right: 20.0),
                                color: Config.primaryColor,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: futCat[index]['onPressed'],
                                        child: Row(
                                          children: <Widget>[
                                            FaIcon(
                                              futCat[index]['icon'],
                                              color: Colors.white,
                                            ),
                                            const SizedBox(
                                              width: 20.0,
                                            ),
                                            Text(
                                              futCat[index][
                                                  'category'], //hard core the user's name at first
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Config.spaceSmall,
                      const Text(
                        'Booking Today', //hard core the user's name at first
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Config.spaceSmall,
                      ground.isNotEmpty
                          ? BookingCard(
                              color: Config.primaryColor,
                              ground: ground,
                            )
                          : Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: Text(
                                    'No Bookings for Today',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                      Config.spaceSmall,
                      const Text(
                        'See Also', //hard core the user's name at first
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Config.spaceSmall,
                      Column(
                        children: List.generate(
                          user['ground'].length,
                          (index) {
                            return GroundCard(
                              // route: 'ground_details',
                              ground: user['ground'][index],

                              //if latest fav contains particular ground id, show fav icon
                              isFav: favList.contains(
                                      user['ground'][index]['ground_id'])
                                  ? true
                                  : false,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );

    });
  }
}
