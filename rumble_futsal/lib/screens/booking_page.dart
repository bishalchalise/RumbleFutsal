import 'package:flutter/material.dart';
import 'package:rumble_futsal/components/booking_card.dart';

import '../utils/config.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}
//for booking status

enum FilterStatus { upcoming, complete, cancel }

class _BookingPageState extends State<BookingPage> {
  FilterStatus status = FilterStatus.upcoming; //initial status
  Alignment _alignment = Alignment.centerLeft;
  List<dynamic> schedules = [
    {
      "ground_name": "Ground 2",
      "ground_profile": "assets/ground2.JPG",
      "category": "5A Side",
      "status": FilterStatus.upcoming,
    },
    {
      "ground_name": "Ground 1",
      "ground_profile": "assets/ground1.jpeg",
      "category": "5A Side",
      "status": FilterStatus.complete,
    },
    {
      "ground_name": "Ground 3",
      "ground_profile": "assets/ground3.jpeg",
      "category": "7A Side",
      "status": FilterStatus.cancel,
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Return Filtered Booking
    List<dynamic> filteredSchedules = schedules.where(
      (var schedule) {
        // switch (schedule['status']) {
        //   case 'available':
        //     schedule['status'] = FilterStatus.available;
        //     break;
        //   case 'booked':
        //     schedule['status'] = FilterStatus.booked;
        //     break;
        //   case 'cancel':
        //     schedule['status'] = FilterStatus.cancel;
        //     break;
        // }
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
                  var _schedule = filteredSchedules[index];
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
                                backgroundImage:
                                    AssetImage(_schedule['ground_profile']),
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _schedule['ground_name'],
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    _schedule['category'],
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
                          const ScheduleCard(),
                          const SizedBox(
                            height: 15.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () {},
                                  child: const Text(
                                    'Cancel',
                                    style:
                                        TextStyle(color: Config.primaryColor),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20.0,
                              ),
                              Expanded(
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: Config.primaryColor,
                                  ),
                                  onPressed: () {},
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
