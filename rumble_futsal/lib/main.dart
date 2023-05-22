import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rumble_futsal/main_layout.dart';
import 'package:rumble_futsal/models/auth_model.dart';
import 'package:rumble_futsal/screens/all_ground_page.dart';
import 'package:rumble_futsal/screens/auth_page.dart';
import 'package:rumble_futsal/screens/booking_ground_page.dart';
import 'package:rumble_futsal/screens/home_page.dart';
import 'package:rumble_futsal/screens/personal_info_page.dart';
import 'package:rumble_futsal/screens/select_referee.dart';
import 'package:rumble_futsal/screens/splash_screen.dart';
import 'package:rumble_futsal/screens/success_booked.dart';
import 'package:rumble_futsal/utils/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize SharedPreferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  // Determine the initial route based on login status
  String initialRoute = isLoggedIn ? 'main' : 'splash';

  runApp(MyApp(initialRoute: initialRoute));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key, required this.initialRoute,
  });
 final String initialRoute;
//push navigator use
  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthModel>(
      create: (context) => AuthModel(),
      child: MaterialApp(
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
        initialRoute: initialRoute,
        routes: {
          //initail routes
          '/': (context) => const AuthPage(),
          //main layout after login
          'main': (context) => const MainLayout(),
          // 'ground_details': (context) => const GroundDetails(),
          'booking_ground_page': (context) => const BookingGroundPage(),
          'success_booking': (context) => const BookingSuccess(),
          'personal_info': (context) => const PersonalInfo(),
          'all_grounds': (context) => const AllGrounds(),
          'referee': (context) => const RefereeProfile(),
          'home': (context) => const Homepage(),
          'splash':(context) => const SplashScreen(),
        },
      ),
    );
  }
}
