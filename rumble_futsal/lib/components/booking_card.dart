import 'package:flutter/material.dart';

import '../utils/config.dart';

class BookingCard extends StatefulWidget {
  const BookingCard({super.key});

  @override
  State<BookingCard> createState() => _BookingCardState();
}

class _BookingCardState extends State<BookingCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Config.primaryColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/ground1.jpeg'),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    Text(
                      'Ground 1',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      height: 2.0,
                    ),
                    Text(
                      '5A Side',
                      style: TextStyle(color: Colors.black),
                    )
                  ],
                ),
              ],
            ),
            Config.spaceSmall,
            //schedule info
            const ScheduleCard(),
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
                    onPressed: () {},
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
                    onPressed: () {},
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
  const ScheduleCard({super.key});

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
        children: const <Widget>[
          Icon(
            Icons.calendar_today,
            color: Config.primaryColor,
            size: 15.0,
          ),
          SizedBox(
            width: 5.0,
          ),
          Text(
            'Monday, 11/11/2023',
            style: TextStyle(color: Config.primaryColor),
          ),
          SizedBox(
            width: 20.0,
          ),
          Icon(
            Icons.access_alarm,
            color: Config.primaryColor,
            size: 17.0,
          ),
          SizedBox(
            width: 5.0,
          ),
          Flexible(
              child: Text(
            '2:00 PM',
            style: TextStyle(color: Config.primaryColor),
          ))
        ],
      ),
    );
  }
}
