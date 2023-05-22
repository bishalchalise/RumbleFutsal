import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/dio_provider.dart';
import '../utils/config.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({
    super.key,
  });

  @override
  State<BookingPage> createState() => _BookingPageState();
}
//for booking status

enum FilterStatus {
  upcoming,
  complete,
  cancel,
}

class _BookingPageState extends State<BookingPage> {
  FilterStatus status = FilterStatus.upcoming; //initial status
  Alignment _alignment = Alignment.centerLeft;
  List<dynamic> schedules = [];

  //get booking details
  Future<void> getBook() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    final booking = await DioProvider().getBook(token);

    if (booking != 'Error') {
      setState(() {
        schedules = json.decode(booking);
        print(schedules);
      });
    }
  }

  @override
  void initState() {
    getBook();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Return Filtered Booking
    List<dynamic> filteredSchedules = schedules.where(
      (var schedule) {
        switch (schedule['status']) {
          case 'upcoming':
            schedule['status'] = FilterStatus.upcoming;
            break;
          case 'complete':
            schedule['status'] = FilterStatus.complete;
            break;
          case 'cancel':
            schedule['status'] = FilterStatus.cancel;
            break;
        }
        return schedule['status'] == status;
      },
    ).toList();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20.0,
          top: 20.0,
          right: 20.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'Booking Schedule',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Config.spaceSmall,
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Row(
                    children: [
                      //filter tabs
                      for (FilterStatus filterStatus in FilterStatus.values)
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (filterStatus == FilterStatus.upcoming) {
                                  status = FilterStatus.upcoming;
                                  _alignment = Alignment.centerLeft;
                                } else if (filterStatus ==
                                    FilterStatus.complete) {
                                  status = FilterStatus.complete;
                                  _alignment = Alignment.center;
                                } else if (filterStatus ==
                                    FilterStatus.cancel) {
                                  status = FilterStatus.cancel;
                                  _alignment = Alignment.centerRight;
                                }
                              });
                            },
                            child: Center(
                              child: Text(filterStatus.name),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                AnimatedAlign(
                  alignment: _alignment,
                  duration: const Duration(milliseconds: 200),
                  child: Container(
                    width: 100.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                      color: Config.primaryColor,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Center(
                      child: Text(
                        status.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Config.spaceSmall,
            Expanded(
              child: ListView.builder(
                itemCount: filteredSchedules.length,
                itemBuilder: ((context, index) {
                  var schedule = filteredSchedules[index];
                  bool isLastElement = filteredSchedules.length + 1 == index;
                  return Card(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    margin: !isLastElement
                        ? const EdgeInsets.only(
                            bottom: 20.0,
                          )
                        : EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.all(
                        15.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                    "http://127.0.0.1:8000${schedule['ground_profile']}"),
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    schedule['ground_name'],
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    schedule['category'],
                                    style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          // schedlue card
                          ScheduleCard(
                            date: schedule['date'],
                            day: schedule['day'],
                            time: schedule['time'],
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                             
                              Expanded(
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: Config.primaryColor,
                                  ),
                                  onPressed: () {
                                  },
                                  child: const Text(
                                    'Rebook',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScheduleCard extends StatelessWidget {
  const ScheduleCard(
      {super.key, required this.date, required this.day, required this.time});

  final String date;
  final String day;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10.0),
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Icon(
            Icons.calendar_today,
            color: Config.primaryColor,
            size: 15.0,
          ),
          const SizedBox(
            width: 5.0,
          ),
          Text(
            '$day, $date',
            style: const TextStyle(color: Config.primaryColor),
          ),
          const SizedBox(
            width: 20.0,
          ),
          const Icon(
            Icons.access_alarm,
            color: Config.primaryColor,
            size: 17.0,
          ),
          const SizedBox(
            width: 5.0,
          ),
          Flexible(
              child: Text(
            time,
            style: const TextStyle(color: Config.primaryColor),
          ))
        ],
      ),
    );
  }
}
