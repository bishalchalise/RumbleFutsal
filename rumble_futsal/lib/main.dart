import 'package:flutter/material.dart';
import 'package:rumble_futsal/main_layout.dart';
import 'package:rumble_futsal/screens/auth_page.dart';
import 'package:rumble_futsal/screens/booking_ground_page.dart';
import 'package:rumble_futsal/screens/ground_details.dart';
import 'package:rumble_futsal/screens/success_booked.dart';
import 'package:rumble_futsal/utils/config.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

//push navigator use
  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'RumbleFutsal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //predefined input decoration
        inputDecorationTheme: const InputDecorationTheme(
          focusColor: Config.primaryColor,
          focusedBorder: Config.focusBorder,
          enabledBorder: Config.outlinedBorder,
          errorBorder: Config.errorBorder,
          border: Config.outlinedBorder,
          floatingLabelStyle: TextStyle(color: Config.primaryColor),
          prefixIconColor: Colors.black38,
        ),
        scaffoldBackgroundColor: Colors.white,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Config.primaryColor,
          selectedItemColor: Colors.white,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          unselectedItemColor: Colors.grey.shade700,
          elevation: 10.0,
          type: BottomNavigationBarType.fixed,
        ),
      ),
      initialRoute: '/',
      routes: {
        //initail routes
        '/' :(context) => const AuthPage(),
        //main layout after login
        'main' :(context) => const MainLayout(),
        'ground_details': (context) => const GroundDetails(),
        'booking_ground_page' :(context) => const BookingGroundPage(), 
        'success_booking' :(context) => const BookingSuccess(),
      },
   
    );
  }
}

