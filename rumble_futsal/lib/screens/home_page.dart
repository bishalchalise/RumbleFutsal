import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rumble_futsal/components/booking_card.dart';
import 'package:rumble_futsal/utils/config.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Map<String, dynamic>> futCat = [
    {
      "icon": FontAwesomeIcons.football,
      "category": "Book Ground",
    },
    {
      "icon": FontAwesomeIcons.person,
      "category": "Referee",
    },
    {
      "icon": FontAwesomeIcons.personArrowUpFromLine,
      "category": "Profile",
    }
  ];

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const <Widget>[
                  Text(
                    'Amanda', //hard core the user's name at first
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    child: CircleAvatar(
                      radius: 30.0,
                      backgroundImage: AssetImage('assets/profile.jpeg'),
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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                    fontSize: 16, color: Colors.white),
                              ),
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
              const BookingCard(),
               Config.spaceSmall,
                const Text(
                'See Also', //hard core the user's name at first
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
