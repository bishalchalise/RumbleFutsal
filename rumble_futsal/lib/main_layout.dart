import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rumble_futsal/screens/booking_page.dart';
import 'package:rumble_futsal/screens/fav_page.dart';
import 'package:rumble_futsal/screens/home_page.dart';
import 'package:rumble_futsal/screens/profile_page.dart';

class MainLayout extends StatefulWidget {
  
  const MainLayout({super.key,});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int currentPage = 0;
  final PageController _page = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _page,
        onPageChanged: (value) {
          setState(() {
            currentPage = value;
          });
        },
        children: const <Widget>[
          Homepage(),
          FavPage(),
          BookingPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        onTap: (page) {
          setState(() {
            currentPage = page;
            _page.animateToPage(page,
                duration: const Duration(microseconds: 500),
                curve: Curves.easeInOut);
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.houseChimney,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.solidHeart,
              
            ),
            label: 'Favourites',
          ),
          BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.solidCalendarCheck,
              ),
              label: 'Bookings'),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.solidUser,
            ),
            label: 'Profile',
            
          ),
        ],
      ),
    );
  }
}
