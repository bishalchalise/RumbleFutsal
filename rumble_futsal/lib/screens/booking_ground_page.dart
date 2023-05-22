import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rumble_futsal/components/button.dart';
import 'package:rumble_futsal/components/custom_appbar.dart';
import 'package:rumble_futsal/utils/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

import '../main.dart';
import '../models/booking_datetime_converted.dart';
import '../providers/dio_provider.dart';

class BookingGroundPage extends StatefulWidget {
  const BookingGroundPage({super.key});

  @override
  State<BookingGroundPage> createState() => _BookingGroundPageState();
}

class _BookingGroundPageState extends State<BookingGroundPage> {
  CalendarFormat _format = CalendarFormat.month;
  DateTime _focusDay = DateTime.now();
  DateTime _currentDay = DateTime.now();
  int? _currentIndex;
  bool _isWeekend = false;
  bool _dateSelected = false;
  bool _timeSelected = false;
  String? token; //to get token for insert booking date and time into database

  Future<void> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? '';
  }

  @override
  void initState() {
    getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    final ground = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: const CustomAppBar(
        appTitle: 'Booking',
        icon: FaIcon(Icons.arrow_back_ios),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Column(
              children: <Widget>[
                //display table calendar
                _tableCalendar(),
                const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 25.0),
                  child: Center(
                    child: Text(
                      "Select Booking Time",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final currentTime = DateTime.now();
                final selectedTime = DateTime(_currentDay.year,
                    _currentDay.month, _currentDay.day, index + 6);
                final isTimeElapsed = selectedTime.isBefore(currentTime);
                return InkWell(
                  splashColor: Colors.transparent,
                  onTap: isTimeElapsed
                      ? null
                      : () {
                          //when selected, update current index and set time selected to true
                            setState(() {
                              _currentIndex = index;
                              _timeSelected = true;
                            });
                         
                        },
                  child: Container(
                    margin: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _currentIndex == index
                            ? Colors.white
                            : Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(
                        15.0,
                      ),
                      color:
                          _currentIndex == index ? Config.primaryColor : null,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${index + 6}:00 ${index + 6 > 11 ? "PM" : "AM"}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _currentIndex == index ? Colors.white : null,
                      ),
                    ),
                  ),
                );
              },
              childCount: 15,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              childAspectRatio: 1.5,
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 80),
              child: Button(
                  width: double.infinity,
                  title: 'Confirm',
                  disable: _timeSelected && _dateSelected ? false : true,
                  onPressed: () async {
                    final getDate = DateConverted.getDate(_currentDay);
                    final getDay = DateConverted.getDay(_currentDay.weekday);
                    final getTime = DateConverted.getTime(_currentIndex!);

                    //using post method using Dio
                    //pass all details
                    final booking = await DioProvider().bookGround(
                        getDate, getDay, getTime, ground['ground_id'], token!);

                    //if status code 200 redirect to booking success
                    if (booking == 200) {
                      MyApp.navigatorKey.currentState!
                          .pushNamed('success_booking');
                    }
                  }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tableCalendar() {
    return TableCalendar(
      focusedDay: _focusDay,
      firstDay: DateTime.now(),
      lastDay: DateTime(2023, 12, 30),
      calendarFormat: _format,
      currentDay: _currentDay,
      rowHeight: 48,
      calendarStyle: const CalendarStyle(
        todayDecoration: BoxDecoration(
          color: Config.primaryColor,
          shape: BoxShape.circle,
        ),
      ),
      availableCalendarFormats: const {
        CalendarFormat.month: 'Month',
      },
      onFormatChanged: (format) {
        setState(() {
          _format = format;
        });
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _currentDay = selectedDay;
          _focusDay = focusedDay;
          _dateSelected = true;
          _timeSelected = false;
        });
      },
    );
  }
}
