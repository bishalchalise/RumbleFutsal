import 'package:flutter/material.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:rumble_futsal/main.dart';
import 'package:rumble_futsal/providers/dio_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/config.dart';

class BookingCard extends StatefulWidget {
  const BookingCard({super.key, required this.color, required this.ground,});
  final Map<String, dynamic> ground;
 

  final Color color;

  @override
  State<BookingCard> createState() => _BookingCardState();
}

class _BookingCardState extends State<BookingCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      "http://127.0.0.1:8000${widget.ground['ground_profile']}"),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.ground["ground_name"],
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(
                      height: 2.0,
                    ),
                    Text(
                      widget.ground["category"],
                      style: const TextStyle(color: Colors.black),
                    )
                  ],
                ),
              ],
            ),
            Config.spaceSmall,
            //schedule info
            ScheduleCard(
              booking: widget.ground['bookings'],
            ),
            Config.spaceSmall,
            //action button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () async {
                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      final token = prefs.getString('token') ?? '';
                      final rating = await DioProvider().cancelBooking(
                       
                       widget.ground['bookings']['id'],
                      widget.ground['ground_id'],
                        token,
                        
                      );
                      //if successful, then refresh
                      if (rating == 200 && rating != '') {
                        MyApp.navigatorKey.currentState!.pushNamed('main');
                      }
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    //rating dialoge
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return RatingDialog(
                              initialRating: 1.0,
                              title: const Text(
                                'Rate Our Ground',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              message: const Text(
                                'Please help us to rate our ground',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15.0,
                                ),
                              ),
                              image: const FlutterLogo(
                                size: 100,
                              ),
                              submitButtonText: 'Submit',
                              commentHint: 'Your Reviews',
                              onSubmitted: (response) async {
                                final SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                final token = prefs.getString('token') ?? '';
                                final rating = await DioProvider().storeReviews(
                                  response.comment,
                                  response.rating,
                                  widget.ground['bookings']['id'],
                                  widget.ground['ground_id'],
                                  token,
                                );
                                //if successful, then refresh
                                if (rating == 200 && rating != '') {
                                  MyApp.navigatorKey.currentState!
                                      .pushNamed('main');
                                }
                              },
                            );
                          });
                    },
                    child: const Text(
                      'Completed',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({super.key, required this.booking});
  final Map<String, dynamic> booking;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(10.0),
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Icon(
            Icons.calendar_today,
            color: Colors.white,
            size: 15.0,
          ),
          const SizedBox(
            width: 5.0,
          ),
          Text(
            '${booking['day']}, ${booking['date']}',
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(
            width: 20.0,
          ),
          const Icon(
            Icons.access_alarm,
            color: Colors.white,
            size: 17.0,
          ),
          const SizedBox(
            width: 5.0,
          ),
          Flexible(
              child: Text(
            booking['time'],
            style: const TextStyle(color: Colors.white),
          ))
        ],
      ),
    );
  }
}
